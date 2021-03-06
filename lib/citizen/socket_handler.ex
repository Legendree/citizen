defmodule Citizen.SocketHandler do
  @behaviour :cowboy_websocket

  def init(req, state) do
    {:cowboy_websocket, req, state, %{}}
  end

  def websocket_init(state) do
    :yes = :global.register_name(:citizen_socket, self())
    :erlang.send_after(10_000, self(), :heartbeat)
    {[{:text, "Connection established."}], state}
  end

  def websocket_handle({:text, "!join" <> user}, state) do
    {[{:text, "Joining the chat with user #{user}"}], state}
  end

  def websocket_handle(:ping, state) do
    {[{:text, "pong"}], state}
  end

  def websocket_handle(_, state) do
    {:ok, state}
  end

  def websocket_info({:msg, msg}, state) do
    {[{:text, msg}], state}
  end

  def websocket_info(:heartbeat, state) do
    :erlang.send_after(10_000, self(), :heartbeat)
    {[{:text, "heartbeat"}], state}
  end

  def websocket_info(_info, state) do
    {[], state}
  end

  def send_message(msg) do
    :erlang.send_after(0, self(), {:msg, msg})
  end

  def print_pid do
    self()
  end

  # defp handle_info({:greet, msg}, state) do
  #  :erlang.start_timer(1000, self(), {:add, "Websockets rock!"})
  #  {:ok, msg, state}
  # end

  # defp handle_info({:add, msg}, state) do
  #  # make it tick
  #  :erlang.start_timer(1000, self(), {:add, "Websockets rock! as a tick ;)"})
  #  {:ok, "Howdy a cool message from Cowboy: #{msg}", state}
  # end
end
