defmodule CitizenTest do
  use ExUnit.Case
  doctest Citizen

  test "greets the world" do
    assert Citizen.hello() == :world
  end
end
