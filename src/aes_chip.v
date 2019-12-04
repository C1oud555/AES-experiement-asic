module aes_chip(
    input  wire chip_clk_i,
    input  wire chip_rstn_i,
    input  wire chip_en_i,
    input  wire chip_test_i,

    input  wire [3: 0] chip_block_i,
    input  wire [3: 0] chip_key_i,

    output wire [7: 0] chip_result_o,
    output wire chip_done_o
);

wire clk, rst_n, en, test;
wire [3: 0] block, key;
wire [7: 0] result;
wire done;
//connect the pad with port;
aes_top top(
    .clk        (clk),
    .rst_n      (rst_n),
    .en         (en),
    .test       (test),
    .block      (block),
    .key        (key),
    .result     (result),
    .done       (done)
);

//input pad
PIDR clk_pad(
    .PAD    (chip_clk_i),
    .C      (clk)
);

PIDR rst_n_pad(
    .PAD    (chip_rstn_i),
    .C      (rst_n)
);

PIDR en_pad(
    .PAD    (chip_en_i),
    .C      (en)
);

PIDR test_pad(
    .PAD    (chip_test_i),
    .C      (test)
);

PIDR block00(
    .PAD    (chip_block_i[0]),
    .C      (block[0])
);

PIDR block01(
    .PAD    (chip_block_i[1]),
    .C      (block[1])
);

PIDR block02(
    .PAD    (chip_block_i[2]),
    .C      (block[2])
);

PIDR block03(
    .PAD    (chip_block_i[3]),
    .C      (block[3])
);

PIDR key00(
    .PAD    (chip_key_i[0]),
    .C      (key[0])
);

PIDR key01(
    .PAD    (chip_key_i[1]),
    .C      (key[1])
);

PIDR key02(
    .PAD    (chip_key_i[2]),
    .C      (key[2])
);

PIDR key03(
    .PAD    (chip_key_i[3]),
    .C      (key[3])
);

//output pad
PO8R done_pad(
    .I      (done),
    .PAD    (chip_done_o)
);

PO8R result00(
    .I      (result[0]),
    .PAD    (chip_result_o[0])
);

PO8R result01(
    .I      (result[1]),
    .PAD    (chip_result_o[1])
);

PO8R result02(
    .I      (result[2]),
    .PAD    (chip_result_o[2])
);

PO8R result03(
    .I      (result[3]),
    .PAD    (chip_result_o[3])
);

PO8R result04(
    .I      (result[4]),
    .PAD    (chip_result_o[4])
);

PO8R result05(
    .I      (result[5]),
    .PAD    (chip_result_o[5])
);

PO8R result06(
    .I      (result[6]),
    .PAD    (chip_result_o[6])
);

PO8R result07(
    .I      (result[7]),
    .PAD    (chip_result_o[7])
);

endmodule