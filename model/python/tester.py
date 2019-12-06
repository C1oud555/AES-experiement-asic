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
block_key = 0x51d0856638566c23c7c8113acc9711a9
block_text = 0x3c163add545c3aad3b8253efab2c9297
# a8b06bd6b8798ae69e9c0b4a719ee7af

# key = (0x00010203, 0x04050607, 0x08090A0B, 0x0C0D0E0F)
# text = (0x01234567, 0x89876543, 0x21012345, 0x67898765)

my_aes.aes_encipher_block(conv_128to4w(block_key), conv_128to4w(block_text))