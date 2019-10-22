module VarintTranslator # LoRDeckCodes

using ..LoRDeckCodes: ArgumentException

const AllButMSB = 0x7f
const JustMSB   = 0x80

function pop_varint(stream::IOBuffer)::Int
    result::UInt = 0
    currentShift = 0
    bytesPopped = 0
    while !eof(stream)
        (byte,) = read(stream, 1)
        current = byte & AllButMSB
        result |= current << currentShift
        (byte & JustMSB) != JustMSB && return Int(result)
        currentShift += 7
    end
    throw(ArgumentException("Byte array did not contain valid varints."))
end

function get_varint(value::Int)::Vector{UInt8}
    buff = zeros(UInt8, 10)
    currentIndex = 1
    iszero(value) && return UInt8[0]
    while !iszero(value)
        byteVal = value & AllButMSB
        value >>= 7
        if !iszero(value)
            byteVal |= JustMSB
        end
        buff[currentIndex] = byteVal
        currentIndex += 1
    end
    buff[1:currentIndex-1]
end

end # module LoRDeckCodes.VarintTranslator
