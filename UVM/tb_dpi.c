#include<svdpi.h>

#include "aes.h"

void tb_dpi(const svOpenArrayHandle key_in, const svOpenArrayHandle text_in, const svOpenArrayHandle data_out){
    int i, *data, *keyin, *text;
    text = (int *) svGetArrayPtr(text_in);
    keyin = (int *) svGetArrayPtr(key_in);
    data = (int *) svGetArrayPtr(data_out);

    uint8_t key[16];
    uint8_t in[16];
    uint8_t out[16];
    uint8_t *w;

    for(i=0; i<16; i++){
        key[i] = keyin[i];
        in[i] = text[i];
    }

    w = aes_init(sizeof(key));
    aes_key_expansion(key, w);
    aes_cipher(in /* in */, out /* out */, w /* expanded key */);




    for (i=0; i<16; i++){
        data[i] = out[i];
    }
}