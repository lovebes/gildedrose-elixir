defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  @aged_brie "Aged Brie"
  @sulfras "Sulfuras, Hand of Ragnaros"
  @backstage "Backstage passes to a TAFKAL80ETC concert"
  @conjured "Conjured Mana Cake"
  @sulfras_quality 80

  @spec update_quality(list(Item)) :: list(Item)
  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  @spec update_item(%Item{:name => binary(), :quality => number(), :sell_in => number()}) ::
          %Item{
            :name => binary(),
            :quality => number(),
            :sell_in => number()
          }
  def update_item(%Item{} = item) do
    item
    |> Item.sanitize_quality()
    |> handle_item_update()
  end

  defp handle_item_update(%Item{name: @conjured, sell_in: sell_in, quality: quality}) do
    new_sell_in = sell_in - 1

    new_item =
      cond do
        new_sell_in < 0 ->
          %Item{
            name: @conjured,
            sell_in: new_sell_in,
            quality: quality - 4
          }

        true ->
          %Item{
            name: @conjured,
            sell_in: new_sell_in,
            quality: quality - 2
          }
      end

    new_item |> Item.sanitize_quality()
  end

  defp handle_item_update(%Item{name: @backstage, sell_in: sell_in, quality: quality}) do
    new_sell_in = sell_in - 1

    new_item =
      cond do
        new_sell_in > 10 ->
          %Item{
            name: @backstage,
            sell_in: new_sell_in,
            quality: quality + 1
          }

        new_sell_in > 5 ->
          %Item{
            name: @backstage,
            sell_in: new_sell_in,
            quality: quality + 2
          }

        new_sell_in >= 0 ->
          %Item{
            name: @backstage,
            sell_in: new_sell_in,
            quality: quality + 3
          }

        true ->
          %Item{
            name: @backstage,
            sell_in: new_sell_in,
            quality: 0
          }
      end

    new_item |> Item.sanitize_quality()
  end

  defp handle_item_update(%Item{name: @sulfras, sell_in: sell_in}) do
    %Item{
      name: @sulfras,
      sell_in: sell_in,
      quality: @sulfras_quality
    }
  end

  defp handle_item_update(%Item{name: @aged_brie, sell_in: sell_in, quality: quality}) do
    new_sell_in = sell_in - 1

    %Item{
      name: @aged_brie,
      sell_in: new_sell_in,
      quality: quality + 1
    }
    |> Item.sanitize_quality()
  end

  defp handle_item_update(%Item{name: name, sell_in: sell_in, quality: quality}) do
    new_sell_in = sell_in - 1

    cond do
      new_sell_in < 0 ->
        %Item{
          name: name,
          sell_in: new_sell_in,
          quality: quality - 2
        }
        |> Item.sanitize_quality()

      true ->
        %Item{
          name: name,
          sell_in: new_sell_in,
          quality: quality - 1
        }
        |> Item.sanitize_quality()
    end
  end
end
