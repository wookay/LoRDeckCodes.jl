using Documenter
using LoRDeckCodes

makedocs(
    build = joinpath(@__DIR__, "local" in ARGS ? "build_local" : "build"),
    modules = [LoRDeckCodes],
    clean = false,
    format = Documenter.HTML(prettyurls = !("local" in ARGS)),
    sitename = "LoRDeckCodes.jl",
    authors = "WooKyoung Noh",
    pages = Any[
        "Home" => "index.md",
    ],
)
