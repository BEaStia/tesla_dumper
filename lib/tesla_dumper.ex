defmodule TeslaDumper do
  @moduledoc """
  This middleware is used for dumping Tesla Env to a curl-playable command.
  """
  @behaviour Tesla.Middleware

  @impl true
  @spec call(map, maybe_improper_list, any) :: any
  def call(env, next, _options) do
    {curl_command, _} =
      {[], env}
      |> build_body()
      |> build_headers()
      |> build_method_and_url()

    env = Map.put(env, :curl_command, Enum.join(curl_command, "\n"))

    Tesla.run(env, next)
  end

  @spec build_body({list, map}) :: {list, map}
  defp build_body({command, %{body: body} = env}) when not is_nil(body) do
    {[~s(-d #{inspect(env.body)}) | command], env}
  end

  defp build_body({command, env}) do
    {command, env}
  end

  @spec build_headers({list, map}) :: {list, map}
  defp build_headers({command, env}) do
    command =
      Enum.reduce(env.headers, command, fn {key, value}, acc ->
        [~s(-H "#{key}: #{value}") | acc]
      end)

    {command, env}
  end

  @spec build_method_and_url({list, map}) :: {list, map}
  defp build_method_and_url({command, env}) do
    {[~s(curl --request #{String.upcase(to_string(env.method))} #{env.url}) | command], env}
  end
end
