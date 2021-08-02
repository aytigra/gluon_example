defmodule GluonExample.Components.UserInfo do
  use Gluon.Component

  @impl true
  def subscribe_to() do
    ["gluon:GluonExample.User", "gluon:GluonExample.Tweet"]
  end

  @impl true
  def data(params) do
    case params["id"] do
      nil ->
        {:error, "no user"}

      user_id ->
        {:ok, user} =
          GluonExample.User
          |> GluonExample.Api.get(user_id)

        attributes = GluonExample.User |> extract_attributes()

        {:ok,
         %{
           data:
             Enum.reduce(attributes, %{}, fn a, acc ->
               Map.put(acc, a.name, Map.get(user, a.name))
             end),
           attributes: attributes
         }}
    end
  end
end
