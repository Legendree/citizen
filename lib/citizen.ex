defmodule Citizen do
  @moduledoc """
  Documentation for `Citizen`.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Citizen.hello()
      :world

  """
  def hello do
    :world
  end

  def send_message_to_client(msg) when is_bitstring(msg) do
    :erlang.send(get_socket_handler_pid(), {:msg, msg})
  end

  def get_socket_handler_pid, do: :global.whereis_name(:citizen_socket)
end
