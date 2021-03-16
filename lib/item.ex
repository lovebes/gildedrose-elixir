defmodule Item do
  defstruct name: nil, sell_in: nil, quality: nil

  @aged_brie "Aged Brie"
  @sulfras "Sulfuras, Hand of Ragnaros"
  @backstage "Backstage passes to a TAFKAL80ETC concert"
  @conjured "Conjured Mana Cake"
  @max_quality 50
  @sulfras_quality 80

  @spec sanitize_quality(%Item{:name => String.t(), :quality => Integer}) :: %Item{
          :name => String.t(),
          :quality => Integer
        }
  def sanitize_quality(%Item{name: name, quality: quality} = item) do
    case name do
      @sulfras ->
        %Item{item | quality: @sulfras_quality}

      _ ->
        %Item{
          item
          | quality:
              quality
              |> min(@max_quality)
              |> max(0)
        }
    end
  end
end
