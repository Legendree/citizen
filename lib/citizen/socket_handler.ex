defmodule Citizen.SocketHandler do
  @behaviour :cowboy_websocket

  def init(req, state) do
    {:cowboy_websocket, req, state, %{idle_timeout: :infinity}}
  end

  def websocket_init(state) do
    :erlang.send_after(1000, self(), {:msg, "Initial message"})
    {[], state}
  end

  def websocket_handle({:text, msg}, state) do
    {[:text, "Howdy! from the Cowboy: #{msg}"], state}
  end

  def websocket_handle(msg, state) do
    IO.puts(msg)
    {:ok, state}
  end

  def websocket_info({:msg, msg}, state) do
    :erlang.send_after(0, self(), :heartbeat)
    {[{:text, msg}], state}
  end

  def websocket_info(:heartbeat, state) do
    :erlang.send_after(10_000, self(), :heartbeat)
    {[{:text, "heartbeat"}], state}
  end

  def websocket_info(_info, state) do
    {[], state}
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
