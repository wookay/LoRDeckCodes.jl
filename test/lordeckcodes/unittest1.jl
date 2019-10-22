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
    deck = Deck(Card.(card_list))
    @test DeckEncoder.encode_deck(deck) == deckcode
end

# SmallDeck
deck = Deck([Card("01DE002", 1)])
@test Deck(DeckEncoder.encode_deck(deck)) == deck

# LargeDeck
deck = Deck([Card("01DE002", 3),
             Card("01DE003", 3),
             Card("01DE004", 3),
             Card("01DE005", 3),
             Card("01DE006", 3),
             Card("01DE007", 3),
             Card("01DE008", 3),
             Card("01DE009", 3),
             Card("01DE010", 3),
             Card("01DE011", 3),
             Card("01DE012", 3),
             Card("01DE013", 3),
             Card("01DE014", 3),
             Card("01DE015", 3),
             Card("01DE016", 3),
             Card("01DE017", 3),
             Card("01DE018", 3),
             Card("01DE019", 3),
             Card("01DE020", 3),
             Card("01DE021", 3)])
deckcode = DeckEncoder.encode_deck(deck)
@test Deck(DeckEncoder.encode_deck(deck)) == deck

# DeckWithCountsMoreThan3Small
deck = Deck([Card("01DE002", 4)])
@test Deck(DeckEncoder.encode_deck(deck)) == deck

# DeckWithCountsMoreThan3Large
deck = Deck([Card("01DE002", 3),
             Card("01DE003", 3),
             Card("01DE004", 3),
             Card("01DE005", 3),
             Card("01DE006", 4),
             Card("01DE007", 5),
             Card("01DE008", 6),
             Card("01DE009", 7),
             Card("01DE010", 8),
             Card("01DE011", 9),
             Card("01DE012", 3),
             Card("01DE013", 3),
             Card("01DE014", 3),
             Card("01DE015", 3),
             Card("01DE016", 3),
             Card("01DE017", 3),
             Card("01DE018", 3),
             Card("01DE019", 3),
             Card("01DE020", 3),
             Card("01DE021", 3)])
deckcode = DeckEncoder.encode_deck(deck)
@test Deck(deckcode) == Deck(deck.cards)

# SingleCard40Times
deck = Deck([Card("01DE002", 40)])
@test Deck(DeckEncoder.encode_deck(deck)) == deck

# WorstCaseLength
deck = Deck([Card("01DE002", 4),
             Card("01DE003", 4),
             Card("01DE004", 4),
             Card("01DE005", 4),
             Card("01DE006", 4),
             Card("01DE007", 5),
             Card("01DE008", 6),
             Card("01DE009", 7),
             Card("01DE010", 8),
             Card("01DE011", 9),
             Card("01DE012", 4),
             Card("01DE013", 4),
             Card("01DE014", 4),
             Card("01DE015", 4),
             Card("01DE016", 4),
             Card("01DE017", 4),
             Card("01DE018", 4),
             Card("01DE019", 4),
             Card("01DE020", 4),
             Card("01DE021", 4)])
@test Deck(DeckEncoder.encode_deck(deck)) == deck

# OrderShouldNotMatter1
deck1 = Deck([Card("01DE002", 1), Card("01DE003", 2), Card("02DE003", 3)])
deck2 = Deck([Card("01DE003", 2), Card("02DE003", 3), Card("01DE002", 1)])
@test DeckEncoder.encode_deck(deck1) == DeckEncoder.encode_deck(deck2)
deck3 = Deck([Card("01DE002", 4), Card("01DE003", 2), Card("02DE003", 3)])
deck4 = Deck([Card("01DE003", 2), Card("02DE003", 3), Card("01DE002", 4)])
@test DeckEncoder.encode_deck(deck3) == DeckEncoder.encode_deck(deck4)

# OrderShouldNotMatter2
deck1 = Deck([Card("01DE002", 4), Card("01DE003", 2), Card("02DE003", 3), Card("01DE004", 5)])
deck2 = Deck([Card("01DE004", 5), Card("01DE003", 2), Card("02DE003", 3), Card("01DE002", 4)])
@test DeckEncoder.encode_deck(deck1) == DeckEncoder.encode_deck(deck2)

# BadCardCodes
@test  DeckEncoder.isvalid(Card("01DE002", 1))
@test !DeckEncoder.isvalid(Card("01DE02", 1))
@test !DeckEncoder.isvalid(Card("01XX002", 1))
using LoRDeckCodes: ArgumentException
@test_throws ArgumentException DeckEncoder.encode_deck(Deck([Card("01DE02", 1)]))

# BadCount
@test !DeckEncoder.isvalid(Card("01DE002", 0))

end # module test_lordeckcodes_unittest1
