defmodule GluonExample.Api do
  use Ash.Api

  resources do
    resource(GluonExample.User)
    resource(GluonExample.Tweet)
  end
end

# {:ok, user} = Ash.Changeset.new(GluonExample.User, %{email: "notify.man@enguento.com"}) |> GluonExample.Api.create()
# GluonExample.Tweet |> Ash.Changeset.new(%{body: "ashy slashy"}) |> Ash.Changeset.replace_relationship(:user, user) |> GluonExample.Api.create()

# {:ok, user} = GluonExample.User |> GluonExample.Api.get("71b7fb6c-5f89-43a4-9918-2deeedad7387")
# Ash.Changeset.new(user, %{email: "update_two@enguento.com"}) |> GluonExample.Api.update()
