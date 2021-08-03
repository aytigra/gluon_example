defmodule Gluon.Components.Grid do
  @callback update(params :: map) :: term

  defmacro __using__(opts \\ []) do
    quote do
      opts = unquote(opts)
      @behaviour unquote(__MODULE__)

      import unquote(__MODULE__)
    end
  end

  def sort(query, %{"sort" => []}) do
    Ash.Query.sort(query, [{:id, :asc}])
  end

  def sort(query, %{"sort" => sort_params}) do
    sort_params
    |> Enum.reduce(query, fn sort_param, q ->
      Ash.Query.sort(q, [
        {String.to_atom(sort_param["colId"]), String.to_atom(sort_param["sort"])}
      ])
    end)
  end

  def sort(query, _) do
    query
  end
end
