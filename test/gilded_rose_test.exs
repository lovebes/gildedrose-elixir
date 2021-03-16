defmodule GildedRoseTest do
  use ExUnit.Case

  test "should lower both sellIn and quality after one day" do
    startCount = 3

    items =
      GildedRose.update_quality([%Item{name: "foo", sell_in: startCount, quality: startCount}])
      |> IO.inspect()

    [%{name: name, sell_in: sell_in, quality: quality} | _] = items

    assert name == "foo"
    assert sell_in == startCount - 1
    assert quality == startCount - 1
  end
end
