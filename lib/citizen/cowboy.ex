defmodule Citizen.Cowboy do
  use GenServer

  @cowboy_server __MODULE__

  def start_link(room_name) when is_bitstring(room_name) do
    GenServer.start_link(@cowboy_server, room_name, name: @cowboy_server)
  end

  def init(room_name) do
    {:ok, _} =
      :cowboy.start_clear(:http, [{:port, 4000}], %{env: %{dispatch: dispatch(room_name)}})

    IO.puts("Started Cowboy server")
    {:ok, nil}
  end

  def terminate(_, state) do
    :ok = :cowboy.stop_listener(:http)
    {:shutdown, state}
  end

  defp dispatch(room_name) do
    :cowboy_router.compile([
      {:_,
       [
         {"/" <> room_name, Citizen.SocketHandler, []}
       ]}
    ])
  end
end
