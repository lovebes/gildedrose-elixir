defmodule GildedRoseTest do
  use ExUnit.Case

  @aged_brie "Aged Brie"
  @sulfras "Sulfuras, Hand of Ragnaros"
  @backstage "Backstage passes to a TAFKAL80ETC concert"
  @conjured "Conjured Mana Cake"
  @max_quality 50
  @sulfras_quality 80

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

    [%{sell_in: sell_in, quality: quality} | _] = updated_items

    assert sell_in == start_sell_in - 1 - 1
    assert start_quality = start_quality - 1 - 2
  end

  test "should make quality never negative as day passes" do
    start_sell_in = 1
    start_quality = 1
    items = [%Item{name: "foo", sell_in: start_sell_in, quality: start_quality}]

    updated_items =
      items
      |> GildedRose.update_quality()
      |> GildedRose.update_quality()

    [%{quality: quality} | _] = updated_items

    assert quality == 0
  end

  test "aged brie increases quality as it gets older" do
    start_sell_in = 10
    start_quality = 1
    items = [%Item{name: @aged_brie, sell_in: start_sell_in, quality: start_quality}]

    updated_items =
      items
      |> GildedRose.update_quality()
      |> GildedRose.update_quality()

    [%{quality: quality} | _] = updated_items

    assert start_quality = start_quality + 1 + 1
  end

  test "should iterate and affect logic correctly to list of items" do
    items = [
      %Item{name: @aged_brie, sell_in: 1, quality: 2},
      %Item{name: "foo", sell_in: 3, quality: 4},
      %Item{name: @sulfras, sell_in: 5, quality: @sulfras_quality},
      %Item{name: @backstage, sell_in: 7, quality: 8}
    ]

    updated_items =
      items
      |> GildedRose.update_quality()

    for %Item{name: name, sell_in: sell_in, quality: quality} = item <- updated_items do
      start_item = items |> Enum.find(nil, fn %Item{name: target_name} -> target_name == name end)

      case name do
        @aged_brie ->
          assert sell_in == start_item.sell_in - 1
          assert quality == start_item.quality + 1

        @sulfras ->
          assert sell_in == start_item.sell_in
          assert quality == @sulfras_quality

        @backstage ->
          assert sell_in == start_item.sell_in - 1
          assert quality == start_item.quality + 2

        _ ->
          assert sell_in == start_item.sell_in - 1
          assert quality == start_item.quality - 1
      end
    end
  end
end
