defmodule GluonExample.Components.UserGrid do
  use Gluon.Component
  use Gluon.Components.Grid

  @impl true
  def subscribe_to() do
    ["gluon:GluonExample.User", "gluon:GluonExample.Tweet"]
  end

  @impl true
  def data(params) do
    {:ok, data} =
      GluonExample.User
      |> sort(params)
      |> GluonExample.Api.read()

    attributes = GluonExample.User |> extract_attributes()

    {:ok,
     %{
       data: extract_data(data, attributes),
       attributes: attributes
     }}
  end

  @impl true
  def update(params) do
    {:ok, user} =
      GluonExample.User
      |> GluonExample.Api.get(params["id"])

    {:ok, user} = user |> Ash.Changeset.for_update(:update, params) |> GluonExample.Api.update()
    attributes = GluonExample.User |> extract_attributes()

    {:ok,
     %{
       data: extract_data([user], attributes),
       attributes: attributes
     }}
  end

  def get_attributes(_params) do
    {:ok, GluonExample.User |> extract_attributes()}
  end

  def extract_data(data, attributes) do
    data
    |> Enum.map(fn user ->
      Enum.reduce(attributes, %{}, fn a, acc ->
        Map.put(acc, a.name, Map.get(user, a.name))
      end)
    end)
  end
end
