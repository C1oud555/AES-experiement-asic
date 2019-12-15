#!/usr/bin/env python3
import aes

def conv_128to4w(text):
    w0 = text >> 96 & 0xffffffff
    w1 = text >> 64 & 0xffffffff
    w2 = text >> 32 & 0xffffffff
    w3 = text  & 0xffffffff
    return (w0, w1, w2, w3)


my_aes = aes.AES()

# input the 128bit of block and key, then run the script.
# the last line will be the result
block_key1 = 0x51d0856638566c23c7c8113acc9711a9
block_text1 = 0x3c163add545c3aad3b8253efab2c9297
# ans1 : a8b06bd6b8798ae69e9c0b4a719ee7af

block_key2 = 0x239eb524e68c87be855fd15d99daea48
block_text2 = 0x0f8c0d86a5964f40f3525db4b9aa2eef
# ans2 : 37cb528d, 0x768ef263, 0xa28f9b9c, 0x1f1da371

block_key3 = 0x15094ed296002566211dbea2ea042d85
block_text3 = 0x90179c110a47eba744f9e4b0077fb5e0
# ans3 : 9e656eca, 0x9711c02b, 0x670aa95b, 0x896a3a17

block_key4 = 0x12bc7a427cf169be5bf920c475ceb9ed
block_text4 = 0xb78a114061bda1b670e985c4e4cf22c9
# ans4 : 0cd459f6, 0x7505547e, 0xbbbe8c27, 0xb1fa4a12

block_key5 = 0x6e7454889b9a105fde845f89d80eabb0
block_text5 = 0x295752264934494cc0a13594e40d772e
# ans5 : 

# key = (0x00010203, 0x04050607, 0x08090A0B, 0x0C0D0E0F)
# text = (0x01234567, 0x89876543, 0x21012345, 0x67898765)

enc_out= my_aes.aes_encipher_block(conv_128to4w(block_key5), conv_128to4w(block_text5))
my_aes.print_block(enc_out)

# dec_out= my_aes.aes_decipher_block(conv_128to4w(block_key2), conv_128to4w(block_text2))
# my_aes.print_block(dec_out)