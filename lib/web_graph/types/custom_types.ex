defmodule WebGraph.CustomTypes do
  use Absinthe.Schema.Notation
  alias Ecto.UUID
  alias Core.{UUID}

  scalar :binary_id do
    parse &parse_uuid/1
    serialize fn(input) ->
      input
    end
  end

  scalar :base_id, name: "Base64Id" do
    parse &parse_base_id/1
    serialize fn(base_id) ->
      base_id
    end
  end

  defp parse_uuid(%Absinthe.Blueprint.Input.String{value: value}) do
    UUID.cast(value)
  end

  defp parse_uuid(%Absinthe.Blueprint.Input.Null{}) do
    {:ok, nil}
  end

  defp parse_uuid(_) do
    :error
  end

  defp parse_base_id(%Absinthe.Blueprint.Input.String{value: value}) do
    case UUID.base_to_string(value) do
      {:ok, string} ->
        {:ok, string}

      _ ->
        :error
    end
  end
  defp parse_base_id(%Absinthe.Blueprint.Input.Null{}) do
    {:ok, nil}
  end
  defp parse_base_id(_) do
    :error
  end
end
