defmodule Citizen.SocketHandler do
  @behaviour :cowboy_websocket

  def init(req, state) do
    {:cowboy_websocket, req, state}
  end

  def websocket_init(state) do
    :erlang.start_timer(1000, self(), {:greet, "Initial message"})
    {[], state}
  end

  def websocket_handle({:text, msg}, state) do
    {[:text, "Howdy! from the Cowboy: #{msg}"], state}
  end

  def websocket_handle(_, state) do
    {[], state}
  end

  def websocket_info({:timeout, _ref, msg}, state) do
    {:ok, msg, state} = handle_info(msg, state)
    {[{:text, msg}], state}
  end

  def websocket_info(_info, state) do
    {[], state}
  end

  defp handle_info({:greet, msg}, state) do
    :erlang.start_timer(1000, self(), {:add, "Websockets rock!"})
    {:ok, msg, state}
  end

  defp handle_info({:add, msg}, state) do
    # make it tick
    :erlang.start_timer(1000, self(), {:add, "Websockets rock! as a tick ;)"})
    {:ok, "Howdy a cool message from Cowboy: #{msg}", state}
  end
end
