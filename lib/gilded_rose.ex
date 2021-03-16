defmodule GildedRose do
  # Example
  # update_quality([%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 9, quality: 1}])
  # => [%Item{name: "Backstage passes to a TAFKAL80ETC concert", sell_in: 8, quality: 3}]

  @aged_brie "Aged Brie"
  @sulfras "Sulfuras, Hand of Ragnaros"
  @backstage "Backstage passes to a TAFKAL80ETC concert"
  @conjured "Conjured Mana Cake"
  @max_quality 50
  @sulfras_quality 80

  @spec update_quality(list(Item)) :: list(Item)
  def update_quality(items) do
    Enum.map(items, &update_item/1)
  end

  @spec update_item(%Item{:name => String.t(), :quality => Integer.t(), :sell_in => Integer.t()}) ::
          %Item{
            :name => String.t(),
            :quality => Integer,
            :sell_in => Integer
          }
  def update_item(%Item{} = item) do
    item
    |> Item.sanitize_quality()
    |> handle_item_update()
    |> IO.inspect()

    # item =
    #   cond do
    #     item.name != "Aged Brie" && item.name != "Backstage passes to a TAFKAL80ETC concert" ->
    #       if item.quality > 0 do
    #         if item.name != "Sulfuras, Hand of Ragnaros" do
    #           %{item | quality: item.quality - 1}
    #         else
    #           item
    #         end
    #       else
    #         item
    #       end

    #     true ->
    #       cond do
    #         item.quality < 50 ->
    #           item = %{item | quality: item.quality + 1}

    #           cond do
    #             item.name == "Backstage passes to a TAFKAL80ETC concert" ->
    #               item =
    #                 cond do
    #                   item.sell_in < 11 ->
    #                     cond do
    #                       item.quality < 50 ->
    #                         %{item | quality: item.quality + 1}

    #                       true ->
    #                         item
    #                     end

    #                   true ->
    #                     item
    #                 end

    #               cond do
    #                 item.sell_in < 6 ->
    #                   cond do
    #                     item.quality < 50 ->
    #                       %{item | quality: item.quality + 1}

    #                     true ->
    #                       item
    #                   end

    #                 true ->
    #                   item
    #               end

    #             true ->
    #               item
    #           end

    #         true ->
    #           item
    #       end
    #   end

    # item =
    #   cond do
    #     item.name != "Sulfuras, Hand of Ragnaros" ->
    #       %{item | sell_in: item.sell_in - 1}

    #     true ->
    #       item
    #   end

    # cond do
    #   item.sell_in < 0 ->
    #     cond do
    #       item.name != "Aged Brie" ->
    #         cond do
    #           item.name != "Backstage passes to a TAFKAL80ETC concert" ->
    #             cond do
    #               item.quality > 0 ->
    #                 cond do
    #                   item.name != "Sulfuras, Hand of Ragnaros" ->
    #                     %{item | quality: item.quality - 1}

    #                   true ->
    #                     item
    #                 end

    #               true ->
    #                 item
    #             end

    #           true ->
    #             %{item | quality: item.quality - item.quality}
    #         end

    #       true ->
    #         cond do
    #           item.quality < 50 ->
    #             %{item | quality: item.quality + 1}

    #           true ->
    #             item
    #         end
    #     end

    #   true ->
    #     item
    # end
  end

  defp handle_item_update(%Item{name: @sulfras, sell_in: sell_in, quality: quality} = item) do
    %Item{
      name: @sulfras,
      sell_in: sell_in,
      quality: @sulfras_quality
    }
  end

  defp handle_item_update(%Item{name: @aged_brie, sell_in: sell_in, quality: quality} = item) do
    new_sell_in = sell_in - 1

    %Item{
      name: @aged_brie,
      sell_in: new_sell_in,
      quality: quality + 1
    }
    |> Item.sanitize_quality()
  end

  defp handle_item_update(%Item{name: name, sell_in: sell_in, quality: quality} = item) do
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
