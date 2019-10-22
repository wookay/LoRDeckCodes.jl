# module LoRDeckCodes

"""
    Card
"""
struct Card
    code::String
    count::Int

    function Card(set::Int, faction::String, number::Int, count::Int)
        new(string(lpad(set, 2, '0'), faction, lpad(number, 3, '0')), count)
    end

    function Card(card_string::AbstractString)
        count, code = split(card_string, ':')
        new(code, parse(Int, count))
    end
end

function Base.getproperty(card::Card, prop::Symbol)
    if prop === :set
        parse(Int, card.code[1:2])
    elseif prop === :faction
        card.code[3:4]
    elseif prop === :number
        parse(Int, card.code[5:7])
    else
        getfield(card, prop)
    end
end

"""
    Deck
"""
struct Deck
    cards::Vector{Card}
    version::UInt8
end

struct ArgumentException <: Exception
    msg::String
end

# module LoRDeckCodes
