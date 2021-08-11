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
    :erlang.start_timer(0, Citizen.Cowboy, msg)
  end
end
