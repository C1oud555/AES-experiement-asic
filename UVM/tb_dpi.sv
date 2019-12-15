import "DPI-C" function void tb_dpi(input bit [7: 0] key[], input bit [7: 0] text[], output bit [7: 0] data[]);

program automatic test;

    class Transaction;
        rand bit [7: 0] key[16];
        rand bit [7: 0] text[16];
    endclass //Transaction

    task automatic trans(bit [7: 0] in[16], ref bit [127: 0] out);
        foreach(in[i])
            out = {out[123:0], in[i]};
    endtask


    bit [7: 0] data[16];
    bit [127: 0] keyl;
    bit [127: 0] datal;
    bit [127: 0] textl;

    initial begin
        Transaction tr;
        tr = new();
        tr.randomize();
        tb_dpi(tr.key, tr.text, data);
        foreach(data[i])
            $display("i: %d, data[i]: %h", i, data[i]);
        trans(tr.key, keyl);
        trans(tr.text, textl);
        trans(data, datal);
        $display("key: %h", keyl);
        $display("text: %h", textl);
        $display("data: %h", datal);
    end

endprogram

