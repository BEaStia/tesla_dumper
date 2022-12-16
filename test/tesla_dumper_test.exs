defmodule TeslaDumperTest do
  use ExUnit.Case
  use Mimic

  doctest TeslaDumper
  alias DummyGithubClient

  setup do
    bypass = Bypass.open()
    {:ok, bypass: bypass}
  end

  test "adds the command to tesla env", %{bypass: bypass} do
    Bypass.expect(bypass, fn conn ->
      Plug.Conn.resp(conn, 200, "Elixir is great!")
    end)

    url = "http://localhost:#{bypass.port}"
    {:ok, env} = DummyGithubClient.user_repos(url, "elixir")
    %{curl_command: cmd} = Map.from_struct(env)

    assert cmd ==
             "curl --request GET http://localhost:#{bypass.port}/elixir\n-H \"authorization: token xyz\""
  end
end
