module Base32 # LoRDeckCodes

using CodecBase: transcode, Base32Encoder, Base32Decoder

function encode(data::Vector{UInt8})::String
    replace(String(transcode(Base32Encoder(), data)), '=' => "")
end

function decode(data::String)::Vector{UInt8}
    len = length(data)
    if !iszero(len % 8)
        n = 8 - len % 8
        data = string(data, repeat('=', n))
    end
    transcode(Base32Decoder(), data)
end

end # module LoRDeckCodes.Base32
