module aes_top(
    input  wire         clk,
    input  wire         rst_n,
    input  wire         en,
    input  wire         test, //1 for seg output;
    input  wire         sel,    //dut to the high density lib, so we can add the decipher part in to the design.

    input  wire [3: 0]  block,
    input  wire [3: 0]  key,

    output wire [7: 0]  result,
    output wire         done
);


wire [127: 0] text_in, key_in;
wire ld;
wire [7: 0] seg, text_out8;
wire done_enc, done_dec;

wire [127: 0] text_out, text_out_enc, text_out_dec;

//the encipher and dec module
aes_cipher_top  enc(
    .clk        (clk),
    .rst        (rst_n),
    .ld         (ld),
    .done       (done_enc),
    .key        (key_in),
    .text_in    (text_in),
    .text_out   (text_out_enc)
);


aes_inv_cipher_top dec(
    .clk        (clk),
    .rst        (rst_n),
    .ld         (ld),
    .kld        (ld),
    .done       (done_dec),
    .key        (key_in),
    .text_in    (text_in),
    .text_out   (text_out_dec)
);

//4 to 128 bit input

aes_4to128 aes_in(clk, rst_n, en, block, key, text_in, key_in, ld);

dispDT_ip disp(clk, rst_n, done, text_out, seg);

aes_128to8 aes_out(clk, rst_n, done, text_out, text_out8);
//control the output

assign text_out = sel ? text_out_enc : text_out_dec;
assign done = sel ? done_enc : done_dec;

assign result = test ? seg : text_out8;

endmodule
