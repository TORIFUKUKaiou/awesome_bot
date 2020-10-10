defmodule AwesomeBotTest do
  use ExUnit.Case
  doctest AwesomeBot

  test "greets the world" do
    assert AwesomeBot.hello() == :world
  end
end
