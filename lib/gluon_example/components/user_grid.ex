defmodule GluonExample.Components.UserGrid do
  use Gluon.Component
  use Gluon.Components.Grid

  @impl true
  def subscribe_to() do
    ["gluon:GluonExample.User", "gluon:GluonExample.Tweet"]
  end

  @impl true
  def data(params) do
    params
    |> IO.inspect(label: "#{__MODULE__}:#{__ENV__.line} #{DateTime.utc_now()}", limit: :infinity)

    {:ok, data} =
      GluonExample.User
      |> sort(params)
      |> GluonExample.Api.read()

    {:ok,
     %{
       data: extract_data(data),
       attributes: GluonExample.User |> extract_attributes()
     }}
  end

  # "sort" => [%{"colId" => "email", "sort" => "asc"}]
  @impl true
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

  def extract_data(data) do
    data
    |> Enum.map(fn u ->
      %{id: u.id, email: u.email}
    end)
  end

  def extract_attributes(resource) do
    resource
    |> Ash.Resource.Info.attributes()
    |> Enum.reduce(%{}, fn a, acc ->
      type =
        a.type |> to_string() |> String.trim_leading("Elixir.Ash.Type.") |> Macro.underscore()

      Map.put(acc, a.name, type)
    end)
  end
end
