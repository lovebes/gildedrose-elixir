defmodule GildedRoseTest do
  use ExUnit.Case

  test "should lower both sellIn and quality after one day" do
    startCount = 3

    items =
      GildedRose.update_quality([%Item{name: "foo", sell_in: startCount, quality: startCount}])

    [%{name: name, sell_in: sell_in, quality: quality} | _] = items

    assert name == "foo"
    assert sell_in == startCount - 1
    assert quality == startCount - 1
  end

  test "should lower quality twice as fast if sell by date has passed" do
    start_sell_in = 1
    start_quality = 5
    items = [%Item{name: "foo", sell_in: start_sell_in, quality: start_quality}]

    updated_items =
      items
      |> GildedRose.update_quality()
      |> GildedRose.update_quality()

    [%{name: name, sell_in: sell_in, quality: quality} | _] = updated_items

    assert sell_in == start_sell_in - 1 - 1
    assert start_quality = start_quality - 1 - 2
  end
end
