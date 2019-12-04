`timescale 1ns/1ps
module tb_aes;

reg  clk, rst_n, en, test;
reg  [3: 0] block, key;

wire done;
wire [7: 0] result;

aes_top dut(
    clk, rst_n, en, test, block, key, result, done
);

always #10 clk = ~clk;

initial begin
    clk = 'b1;
    rst_n = 'b0;
    en = 'b0;
    block = 4'b0101;
    key = 4'b0101;
    test = 'b1;
	#10 rst_n = 'b1;
    #50 en = 'b1;
    #20 en = 'b0;
    #100;
    block = 4'b0101;
    key = 4'b0101;
    #1000;en = 'b1;
    #20 en = 'b0; test = 'b0;
    #5000;
    $finish();
end

initial begin
	//$vcdpluson;
    $fsdbDumpfile("aes.fsdb");
    $fsdbDumpvars(0,dut);
end

always @(dut.done) begin
    $display("text_in : %h", dut.text_in);
    $display("key_in : %h", dut.key_in);
    $display("text_out : %h", dut.text_out);
    $display("done : %b", dut.enc.done);
    $display("ld : %h", dut.ld);
end

endmodule
