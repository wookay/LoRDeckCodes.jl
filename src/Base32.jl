module Base32 # LoRDeckCodes

using CodecBase: transcode, Base32Encoder, Base32Decoder

function encode(data::Vector{UInt8})::String
    replace(String(transcode(Base32Encoder(), data)), '=' => "")
end

function decode(data::String)::Vector{UInt8}
    len = length(data)
    if len < 16
        n = rem(16, len)
    elseif len < 128
        n = len % 8
    else
        n = len ÷ 128
    end
    if !iszero(n)
        data = string(data, repeat('=', n))
    end
    transcode(Base32Decoder(), data)
end

end # module LoRDeckCodes.Base32
