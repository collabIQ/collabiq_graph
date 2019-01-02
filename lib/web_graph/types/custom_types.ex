defmodule WebGraph.CustomTypes do
  use Absinthe.Schema.Notation
  alias Core.Validate

  scalar :binary_id do
    parse fn(input) ->
      Validate.binary_id(input.value)
    end
    serialize fn(input) ->
      input
    end
  end
end
