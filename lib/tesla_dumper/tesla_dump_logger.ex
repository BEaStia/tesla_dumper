defmodule TeslaDumper.TeslaDumpLogger do
  @moduledoc """
    Logging middleware that just logs the curl
  """
  @behaviour Tesla.Middleware

  require Logger
  @impl true
  def call(env, next, _options) do
    %{curl_command: curl_command} = Map.from_struct(env)
    Logger.info(curl_command)

    Tesla.run(env, next)
  end
end
