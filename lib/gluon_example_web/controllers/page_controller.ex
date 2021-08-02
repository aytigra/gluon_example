defmodule GluonExampleWeb.PageController do
  use GluonExampleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", props: Jason.encode!(%{name: "bar"}))
  end

  def add_users(conn, _params) do
    1..100
    |> Enum.each(fn _ ->
      {s, ms} = DateTime.utc_now() |> DateTime.to_gregorian_seconds()

      Ash.Changeset.new(GluonExample.User, %{email: "#{s}#{ms}@gluon.test"})
      |> GluonExample.Api.create()
    end)

    redirect(conn, to: "/")
  end
end
