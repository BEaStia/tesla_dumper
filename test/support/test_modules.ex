defmodule DummyGithubClient do
  @moduledoc """
  Simple example of Tesla Client.
  """
  use Tesla

  plug(Tesla.Middleware.Headers, [{"authorization", "token xyz"}])
  plug(Tesla.Middleware.JSON)
  plug(TeslaDumper)

  def user_repos(url, login) do
    get(url <> "/" <> login)
  end
end
