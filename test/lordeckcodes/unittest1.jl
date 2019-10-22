module test_lordeckcodes_unittest1

using Test
using LoRDeckCodes

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

end # module test_lordeckcodes_unittest1
