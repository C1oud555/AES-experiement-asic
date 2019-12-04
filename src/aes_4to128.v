module aes_4to128(
    input  wire         clk,
    input  wire         rst_n,
    input  wire         en,
    input  wire [3: 0]  block,
    input  wire [3: 0]  key,
    output wire [127: 0]    text_in,
    output wire [127: 0]    key_in,
    output wire             ld
);

parameter idle  = 3'b001, load = 3'b010, done = 3'b100;

reg [127: 0] text_r, key_r;
reg ld_r;
reg [2: 0] state;
reg [4: 0] count;

assign key_in = key_r;
assign text_in = text_r;
assign ld = ld_r;

always  @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        state <= idle;
        text_r <= 'b0;
        key_r <= 'b0;
        ld_r <= 'b0;
        count <= 'b0;
    end else begin
        case (state)
            idle: begin
                if (en) begin
                    state <= load;
                    count <= 'b0;
                end else begin
                    state <= idle;
                end
            end

            load: begin
                count <= count + 'b1;
                text_r <= {text_r[123: 0], block};
                key_r <= {key_r[123: 0], key};
                if ( & count ) begin
                    state <= done;
                    ld_r <= 'b1;
                end else begin
                    state <= load;
                end
            end

            done: begin
                ld_r <= 'b0;
                state <= idle;
            end
            default: state <= idle;
        endcase
    end
end


endmodule