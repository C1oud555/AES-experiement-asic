
module dispDT_ip(
    input  wire clk,
    input  wire rst_n,
    input  wire done,
    input  wire [127: 0] input_data,
    output wire [7: 0] seg
);

reg [7: 0] seg_r;
reg [127: 0] tmp_data;
reg [14: 0] count;
reg div_clk;

wire  [3: 0] disp_data;

assign seg = seg_r;

always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        tmp_data <= 'b0;
        seg_r <= 'b0;
    end else if (done)
        tmp_data <= input_data;
    else
        tmp_data <= {tmp_data[123: 0], tmp_data[127: 124]};
end

assign disp_data = tmp_data[3: 0];

always @(posedge clk or negedge rst_n) begin
    if(rst_n) begin
        count <= 'b0;
        div_clk <= 'b0;
    end else if (& count) begin
        count <= 'b0;
        div_clk <= ~div_clk;
    end else
        count <= count + 'b1;
end


always @(posedge div_clk) begin
    case (disp_data)
        4'h0: seg_r = ~ 8'hc0;
        4'h1: seg_r = ~ 8'hf9;
        4'h2: seg_r = ~ 8'ha4;
        4'h3: seg_r = ~ 8'hb0;
        4'h4: seg_r = ~ 8'h99;
        4'h5: seg_r = ~ 8'h92;
        4'h6: seg_r = ~ 8'h82;
        4'h7: seg_r = ~ 8'hf8;
        4'h8: seg_r = ~ 8'h80;
        4'h9: seg_r = ~ 8'h90;
        4'ha: seg_r = ~ 8'h88;
        4'hb: seg_r = ~ 8'h83;
        4'hc: seg_r = ~ 8'hc6;
        4'hd: seg_r = ~ 8'ha1;
        4'he: seg_r = ~ 8'h86;
        4'hf: seg_r = ~ 8'h8e;
    endcase
end          
endmodule
