module test_lordeckcodes_unittest1

using Test
using LoRDeckCodes

# EncodeDecodeRecommendedDecks
function read_remove_bom(path::String)
    bytes = read(path)
    bytes[1:3] == [0xef, 0xbb, 0xbf] && deleteat!(bytes, 1:3)
    String(bytes)
end
deck_blocks = split(read_remove_bom(normpath(@__DIR__, "DeckCodesTestData.txt")), "\n\n")
for deck_block in deck_blocks
    isempty(deck_block) && continue
    deckcode_and_card_list = split(deck_block, "\n")
    deckcode = first(deckcode_and_card_list)
    card_list = deckcode_and_card_list[2:end]
    deck = Deck(CardCodeAndCount.(card_list))
    @test DeckEncoder.encode_deck(deck) == deckcode
end

# SmallDeck
deck = Deck([CardCodeAndCount("01DE002", 1)])
@test Deck(DeckEncoder.encode_deck(deck)) == deck

# LargeDeck
deck = Deck([CardCodeAndCount("01DE002", 3),
             CardCodeAndCount("01DE003", 3),
             CardCodeAndCount("01DE004", 3),
             CardCodeAndCount("01DE005", 3),
             CardCodeAndCount("01DE006", 3),
             CardCodeAndCount("01DE007", 3),
             CardCodeAndCount("01DE008", 3),
             CardCodeAndCount("01DE009", 3),
             CardCodeAndCount("01DE010", 3),
             CardCodeAndCount("01DE011", 3),
             CardCodeAndCount("01DE012", 3),
             CardCodeAndCount("01DE013", 3),
             CardCodeAndCount("01DE014", 3),
             CardCodeAndCount("01DE015", 3),
             CardCodeAndCount("01DE016", 3),
             CardCodeAndCount("01DE017", 3),
             CardCodeAndCount("01DE018", 3),
             CardCodeAndCount("01DE019", 3),
             CardCodeAndCount("01DE020", 3),
             CardCodeAndCount("01DE021", 3)])
deckcode = DeckEncoder.encode_deck(deck)
@test Deck(DeckEncoder.encode_deck(deck)) == deck

# DeckWithCountsMoreThan3Small
deck = Deck([CardCodeAndCount("01DE002", 4)])
@test Deck(DeckEncoder.encode_deck(deck)) == deck

# DeckWithCountsMoreThan3Large
deck = Deck([CardCodeAndCount("01DE002", 3),
             CardCodeAndCount("01DE003", 3),
             CardCodeAndCount("01DE004", 3),
             CardCodeAndCount("01DE005", 3),
             CardCodeAndCount("01DE006", 4),
             CardCodeAndCount("01DE007", 5),
             CardCodeAndCount("01DE008", 6),
             CardCodeAndCount("01DE009", 7),
             CardCodeAndCount("01DE010", 8),
             CardCodeAndCount("01DE011", 9),
             CardCodeAndCount("01DE012", 3),
             CardCodeAndCount("01DE013", 3),
             CardCodeAndCount("01DE014", 3),
             CardCodeAndCount("01DE015", 3),
             CardCodeAndCount("01DE016", 3),
             CardCodeAndCount("01DE017", 3),
             CardCodeAndCount("01DE018", 3),
             CardCodeAndCount("01DE019", 3),
             CardCodeAndCount("01DE020", 3),
             CardCodeAndCount("01DE021", 3)])
deckcode = DeckEncoder.encode_deck(deck)
@test Deck(deckcode) == Deck(deck.cards)

# SingleCardCodeAndCount40Times
deck = Deck([CardCodeAndCount("01DE002", 40)])
@test Deck(DeckEncoder.encode_deck(deck)) == deck

# WorstCaseLength
deck = Deck([CardCodeAndCount("01DE002", 4),
             CardCodeAndCount("01DE003", 4),
             CardCodeAndCount("01DE004", 4),
             CardCodeAndCount("01DE005", 4),
             CardCodeAndCount("01DE006", 4),
             CardCodeAndCount("01DE007", 5),
             CardCodeAndCount("01DE008", 6),
             CardCodeAndCount("01DE009", 7),
             CardCodeAndCount("01DE010", 8),
             CardCodeAndCount("01DE011", 9),
             CardCodeAndCount("01DE012", 4),
             CardCodeAndCount("01DE013", 4),
             CardCodeAndCount("01DE014", 4),
             CardCodeAndCount("01DE015", 4),
             CardCodeAndCount("01DE016", 4),
             CardCodeAndCount("01DE017", 4),
             CardCodeAndCount("01DE018", 4),
             CardCodeAndCount("01DE019", 4),
             CardCodeAndCount("01DE020", 4),
             CardCodeAndCount("01DE021", 4)])
@test Deck(DeckEncoder.encode_deck(deck)) == deck

# OrderShouldNotMatter1
deck1 = Deck([CardCodeAndCount("01DE002", 1), CardCodeAndCount("01DE003", 2), CardCodeAndCount("02DE003", 3)])
deck2 = Deck([CardCodeAndCount("01DE003", 2), CardCodeAndCount("02DE003", 3), CardCodeAndCount("01DE002", 1)])
@test DeckEncoder.encode_deck(deck1) == DeckEncoder.encode_deck(deck2)
deck3 = Deck([CardCodeAndCount("01DE002", 4), CardCodeAndCount("01DE003", 2), CardCodeAndCount("02DE003", 3)])
deck4 = Deck([CardCodeAndCount("01DE003", 2), CardCodeAndCount("02DE003", 3), CardCodeAndCount("01DE002", 4)])
@test DeckEncoder.encode_deck(deck3) == DeckEncoder.encode_deck(deck4)

# OrderShouldNotMatter2
deck1 = Deck([CardCodeAndCount("01DE002", 4), CardCodeAndCount("01DE003", 2), CardCodeAndCount("02DE003", 3), CardCodeAndCount("01DE004", 5)])
deck2 = Deck([CardCodeAndCount("01DE004", 5), CardCodeAndCount("01DE003", 2), CardCodeAndCount("02DE003", 3), CardCodeAndCount("01DE002", 4)])
@test DeckEncoder.encode_deck(deck1) == DeckEncoder.encode_deck(deck2)

# BadCardCodeAndCountCodes
@test  DeckEncoder.isvalid(CardCodeAndCount("01DE002", 1))
@test !DeckEncoder.isvalid(CardCodeAndCount("01DE02", 1))
@test !DeckEncoder.isvalid(CardCodeAndCount("01XX002", 1))
using LoRDeckCodes: ArgumentException
@test_throws ArgumentException DeckEncoder.encode_deck(Deck([CardCodeAndCount("01DE02", 1)]))

# BadCount
@test !DeckEncoder.isvalid(CardCodeAndCount("01DE002", 0))

end # module test_lordeckcodes_unittest1
