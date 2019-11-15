module test_lordeckcodes_deckencoder

using Test
using LoRDeckCodes

deckcode = "CEAAECABAIDASDASDISC2OIIAECBGGY4FAWTINZ3AICACAQXDUPCWBABAQGSOKRM"
deck = Deck(deckcode)
@test length(deck.cards) == 24
@test DeckEncoder.MAX_KNOWN_VERSION == deck.version
@test DeckEncoder.encode_deck(deck) == deckcode

deck2 = Deck(SubString(deckcode))
@test deck == deck2

end # module test_lordeckcodes_deckencoder
