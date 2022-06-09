defmodule PlaygroundTest do
  use ExUnit.Case
  doctest Playground

  test "greets the world" do
    assert Playground.hello() == :world
  end

  test "Spawns a process" do
    assert Playground.start() == {:ok, "spawned process"}
  end

  test "Sends message with value" do
    Playground.view(self())
    assert_receive{:view, _}
  end
end
