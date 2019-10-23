# LoRDeckCodes.jl

|  **Documentation**                        |  **Build Status**                                                |
|:-----------------------------------------:|:----------------------------------------------------------------:|
|  [![][docs-latest-img]][docs-latest-url]  |  [![][travis-img]][travis-url]  [![][codecov-img]][codecov-url]  |

It's a [Julia](https://julialang.org/) package to encode, decode the deck used for [Legends of Runeterra](https://playruneterra.com).
the original repository is [RiotGames/LoRDeckCodes](https://github.com/RiotGames/LoRDeckCodes).

```julia
julia> using LoRDeckCodes

julia> deck = Deck("CEBAIAIFAEHSQNQIAEAQGDAUDAQSOKJUAIAQCBI5AEAQCFYA")
Deck(CardCodeAndCount[CardCodeAndCount("01SI001", 3), CardCodeAndCount("01SI015", 3), CardCodeAndCount("01SI040", 3), CardCodeAndCount("01SI054", 3), CardCodeAndCount("01FR003", 3), CardCodeAndCount("01FR012", 3), CardCodeAndCount("01FR020", 3), CardCodeAndCount("01FR024", 3), CardCodeAndCount("01FR033", 3), CardCodeAndCount("01FR039", 3), CardCodeAndCount("01FR041", 3), CardCodeAndCount("01FR052", 3), CardCodeAndCount("01SI029", 2), CardCodeAndCount("01FR023", 2)], 0x01)

julia> DeckEncoder.encode_deck(deck)
"CEBAIAIFAEHSQNQIAEAQGDAUDAQSOKJUAIAQCBI5AEAQCFYA"
```

### Installation
 * `]` key on Julia REPL.
```julia
(v1.1) pkg> add https://github.com/wookay/LoRDeckCodes.jl.git
```


[docs-latest-img]: https://img.shields.io/badge/docs-latest-blue.svg
[docs-latest-url]: https://wookay.github.io/docs/LoRDeckCodes.jl/

[travis-img]: https://api.travis-ci.org/wookay/LoRDeckCodes.jl.svg?branch=master
[travis-url]: https://travis-ci.org/wookay/LoRDeckCodes.jl

[codecov-img]: https://codecov.io/gh/wookay/LoRDeckCodes.jl/branch/master/graph/badge.svg
[codecov-url]: https://codecov.io/gh/wookay/LoRDeckCodes.jl/branch/master
