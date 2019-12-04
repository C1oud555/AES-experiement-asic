module tb_4to128;

reg clk, rst_n, en;
reg [3: 0] block, key;
wire [127: 0] text_in, key_in;
wire ld, kld;

aes_4to128 dut(clk, rst_n, en, block, key, text_in, key_in, ld);

always #10 clk = ~clk;

initial begin
    clk = 1'b1;
    rst_n = 'b0;
    en = 0;
    block = 4'b0101;
    key = 4'b1010;

    #10 rst_n = 1;
    #50 en = 1;
    #20 en = 0;

   #200 block = 4'b1010;

    #1000 $finish();
end

always @(dut.count or dut.state) begin
        $display("count : %d", dut.count);
        $display("state : %d", dut.state);
        $display("text : %h\nkey : %h \n ld: %b", text_in, key_in, ld);
end

endmodule
