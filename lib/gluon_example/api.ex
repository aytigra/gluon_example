defmodule GluonExample.Api do
  use Ash.Api

  resources do
    resource GluonExample.User
    resource GluonExample.Tweet
  end
end


# {:ok, user} = Ash.Changeset.new(GluonExample.User, %{email: "notify.man@enguento.com"}) |> GluonExample.Api.create()
# GluonExample.Tweet |> Ash.Changeset.new(%{body: "ashy slashy"}) |> Ash.Changeset.replace_relationship(:user, user) |> GluonExample.Api.create()
