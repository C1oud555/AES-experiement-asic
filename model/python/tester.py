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
block_key = 0x2b7e151628aed2a6abf7158809cf4f3c
block_text = 0x6bc1bee22e409f96e93d7e117393172a


# key = (0x00010203, 0x04050607, 0x08090A0B, 0x0C0D0E0F)
# text = (0x01234567, 0x89876543, 0x21012345, 0x67898765)

my_aes.aes_encipher_block(conv_128to4w(block_key), conv_128to4w(block_text))