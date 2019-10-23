# module LoRDeckCodes

"""
```julia
struct CardCodeAndCount
    code::String
    count::Int
end
```
"""
struct CardCodeAndCount 
    code::String
    count::Int

    function CardCodeAndCount(code::String, count::Int)
        new(code, count)
    end

    function CardCodeAndCount(set::Int, faction::String, number::Int, count::Int)
        new(string(lpad(set, 2, '0'), faction, lpad(number, 3, '0')), count)
    end

    function CardCodeAndCount(card_string::AbstractString)
        count, code = split(card_string, ':')
        new(code, parse(Int, count))
    end
end

function Base.getproperty(card::CardCodeAndCount, prop::Symbol)
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
    cards::Vector{CardCodeAndCount}
    version::UInt8
end
```
"""
struct Deck
    cards::Vector{CardCodeAndCount}
    version::UInt8
end

function Base.:(==)(a::Deck, b::Deck)
    by = x -> (x.code, x.count)
    length(a.cards) == length(b.cards) && sort(a.cards, by = by) == sort(b.cards, by = by) && a.version == b.version
end

struct ArgumentException <: Exception
    msg::String
end

# module LoRDeckCodes
