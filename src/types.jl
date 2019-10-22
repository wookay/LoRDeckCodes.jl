# module LoRDeckCodes

"""
```julia
struct Card
    code::String
    count::Int
end
```
"""
struct Card
    code::String
    count::Int

    function Card(code::String, count::Int)
        new(code, count)
    end

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
```julia
struct Deck
    cards::Vector{Card}
    version::UInt8
end
```
"""
struct Deck
    cards::Vector{Card}
    version::UInt8
end

Base.isless(a::Card, b::Card) = isless((a.code, a.count), (b.code, b.count))
Base.:(==)(a::Deck, b::Deck) = length(a.cards) == length(b.cards) && sort(a.cards) == sort(b.cards) && a.version == b.version

struct ArgumentException <: Exception
    msg::String
end

# module LoRDeckCodes
