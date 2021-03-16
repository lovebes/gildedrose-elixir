defmodule Item do
  defstruct name: nil, sell_in: nil, quality: nil

  @sulfras "Sulfuras, Hand of Ragnaros"
  @max_quality 50
  @sulfras_quality 80

  @spec sanitize_quality(%Item{:name => binary(), :quality => number()}) :: %Item{
          :name => String.t(),
          :quality => number()
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
