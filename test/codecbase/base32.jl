module test_codecbase_base32

using Test
using CodecBase

@test transcode(Base32Encoder(), "apple") == b"MFYHA3DF"
@test transcode(Base32Encoder(hex=true), "apple") == b"C5O70R35"

@test transcode(Base32Decoder(), "MFYHA3DF") == b"apple"
@test transcode(Base32Decoder(hex=true), "C5O70R35") == b"apple"

end # module test_codecbase_base32
