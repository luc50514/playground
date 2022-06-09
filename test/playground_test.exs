defmodule PlaygroundTest do
  use ExUnit.Case
  doctest Playground

  test "greets the world" do
    assert Playground.hello() == :world
  end

  test "View should return current value 0" do
    playground = Playground.start()
    send(playground, {:view, self()})
    assert_receive{:response, 0}
    assert Playground.view(playground) == 0

  end

  test "Adds should return 1 when given 1" do
    playground = Playground.start()
    assert Playground.add(playground, 1) == 1
  end

  test "Adds should return 100 when given 100" do
    playground = Playground.start()
    assert Playground.add(playground, 100) == 100
  end

  test "Adds should return 101 when given 100 with current value of 1" do
    playground = Playground.start()
    Playground.add(playground, 1)
    assert Playground.add(playground, 100) == 101
  end

  test "Subtract should return -1 when given -1" do
    playground = Playground.start()
    assert Playground.subtract(playground, 1) == -1
  end

  test "Division should return 0 when given 1" do
    playground = Playground.start()
    assert Playground.division(playground, 1) == 0
  end

  test "Multiply should return 1 when given 1" do
    playground = Playground.start()
    assert Playground.multiply(playground, 1) == 0
  end

  test "Multiply should return 11 when using enum map of 1 to 100" do
    playground = Playground.start(1)
    assert Enum.reduce(1..10, fn valuetouse, acc -> Playground.add(playground, valuetouse + acc) end ) == 2036
  end
end
