# TeslaDumper

This package allows to dump Tesla requests to curl.
It can be produced in two middlewares:
1) `plug(TeslaDumper)` adds simple curl command to Tesla.Env
2) `plug(TeslaDumpLogger)` just logs the curl command with Info level.

If you want to change the behavior of logging - Just create your own logger(using TeslaDumpLogger as example) and process curl command.


## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed
by adding `tesla_dumper` to your list of dependencies in `mix.exs`:

```elixir
def deps do
  [
    {:tesla_dumper, "~> 0.1.0"}
  ]
end
```

Then you can middlewares to Tesla Client:


```elixir
defmodule DummyGithubClient do
  use Tesla

  plug(Tesla.Middleware.Headers, [{"authorization", "token xyz"}])
  plug(Tesla.Middleware.JSON)
  plug(TeslaDumper)

  def user_repos(url, login) do
    get(url <> "/" <> login)
  end
end
```

Documentation can be generated with [ExDoc](https://github.com/elixir-lang/ex_doc)
and published on [HexDocs](https://hexdocs.pm). Once published, the docs can
be found at <https://hexdocs.pm/tesla_dumper>.

