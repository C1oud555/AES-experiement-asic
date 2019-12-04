module aes_128to8(
    input  wire             clk,
    input  wire             rst_n,
    input  wire             done,
    input  wire [127: 0]    data,

    output wire [7: 0]      text_out8
);

parameter idle = 2'b01, load = 2'b10;

reg [127: 0] text_out_r;
reg [1: 0] state;
reg [3: 0] count;

assign text_out8 = text_out_r[7: 0];

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= idle;
        text_out_r <= 'b0;
        count <= 'b0;
    end else begin
        case (state)
            idle: begin
                if(done) begin
                    state <= load;
                    text_out_r <= data;
                    count <= 'b0;
                end else begin
                    state <= idle;
                    text_out_r <= 'b0;
                end
            end

            load: begin
                count <= count +'b1;
                text_out_r <= {text_out_r[119: 0], text_out_r[127: 120]};
                if( & count ) begin
                    state <= idle;
                end else begin
                    state <= load;
                end
            end

            default: state <= idle;
        endcase
    end
end

endmodule