defmodule GluonExampleWeb.PageController do
  use GluonExampleWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
