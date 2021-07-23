defmodule GluonExampleWeb.PageController do
  use GluonExampleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html", props: Jason.encode!(%{name: "bar"}))
  end
end
