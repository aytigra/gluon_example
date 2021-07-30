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

        {:ok, %{id: user.id, email: user.email}}
    end
  end
end
