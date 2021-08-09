defmodule Citizen.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    {:ok, _} = :cowboy.start_clear(:http, [{:port, 4000}], %{env: %{dispatch: dispatch()}})
    IO.puts("Started Cowboy server")
    children = []

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: Citizen.Supervisor]
    Supervisor.start_link(children, opts)
  end

  defp dispatch do
    :cowboy_router.compile([
      {:_,
       [
         {"/websocket", Citizen.SocketHandler, []}
       ]}
    ])
  end
end
