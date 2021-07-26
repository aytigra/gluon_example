defmodule GluonExample.Components.UserGrid do
  use Gluon.Component
  use Gluon.Components.Grid

  @impl true
  def subscribe_to() do
    ["gluon:GluonExample.User", "gluon:GluonExample.Tweet"]
  end

  @impl true
  def data(_params) do
    {:ok, data} = GluonExample.User |> GluonExample.Api.read()

    {:ok,
     %{
       data: extract_data(data),
       attributes: GluonExample.User |> extract_attributes()
     }}
  end

  @impl true
  def sort() do
    ""
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
