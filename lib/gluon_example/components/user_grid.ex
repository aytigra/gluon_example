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

    {:ok,
     %{
       data: extract_data(data),
       attributes: GluonExample.User |> extract_attributes()
     }}
  end

  @impl true
  def update(params) do
    {:ok, user} =
      GluonExample.User
      |> GluonExample.Api.get(params["id"])

    {:ok, user} = user |> Ash.Changeset.for_update(:update, params) |> GluonExample.Api.update()

    {:ok,
     %{
       data: extract_data([user]),
       attributes: GluonExample.User |> extract_attributes()
     }}
  end

  def extract_data(data) do
    data
    |> Enum.map(fn u ->
      %{id: u.id, email: u.email}
    end)
  end
end
