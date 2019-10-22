module Base32 # LoRDeckCodes

using CodecBase: transcode, Base32Encoder, Base32Decoder

encode(data::Vector{UInt8})::String = replace(String(transcode(Base32Encoder(), data)), '=' => "")
decode(data::String)::Vector{UInt8} = transcode(Base32Decoder(), data)

end # module LoRDeckCodes.Base32
