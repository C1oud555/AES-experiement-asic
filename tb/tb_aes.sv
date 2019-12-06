module tb_pra;

class Transaction;
    rand logic [127: 0] text_in, key_in;

    function new();
    endfunction //new()
endclass //Transaction

task automatic datatrans(reg [127: 0] text_in, reg [127: 0] key_in, ref reg clk, ref reg en, ref reg [3: 0] data, ref reg [3: 0] key);
    $display("text_in: %h", text_in);
    $display("key_in: %h", key_in);
    @(posedge clk) en = 'b1;
    for (int i=0; i<32; i++) begin
        @ (posedge clk);
        en = 'b0;
        data = text_in[127: 124];
        key = key_in[127: 124];
        text_in = text_in << 4;
        key_in = key_in << 4;
    end
    
endtask //datatrans

task automatic datarecieve(const ref reg [7: 0] result, const ref reg done, ref reg clk, ref reg [127: 0] data_recv);
    @(posedge clk);
    @(posedge clk);
    for (int i=0; i<16; i++) begin
        @(posedge clk);
        data_recv = {data_recv[120: 0], result};
    end
    $display("data_recv: %h", data_recv);
endtask //datarecieve

parameter T = 'd20;

reg clk, rst_n, en, test;
reg [127: 0] text_in, data_recv;
reg [3: 0] block, key;
reg done;
reg [7: 0] result;

always # (T/2) clk = ~clk;

initial begin
    Transaction trans;
    trans = new();
    clk = 'b1;
    rst_n = 'b0;
    en = 1;
    test = 0;
    # (3*T) rst_n = 'b1;
    trans.randomize();
    text_in = trans.text_in;
    datatrans(trans.text_in, trans.key_in, clk, en, block, key);
end

initial fork
    
    # (100 * T) $finish();
join

always @(posedge done) fork
    datarecieve(result, done, clk, data_recv);
    $display("text_in_indut: %h", dut.text_in);
    $display("key_in_indut: %h", dut.key_in);
    $display("text_out_indut: %h", dut.text_out);

join
aes_top dut(clk, rst_n, en, test, block, key, result, done);
endmodule