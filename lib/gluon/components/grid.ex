defmodule Gluon.Components.Grid do
  def subscribe_to() do
    ["gluon:Elixir.GluonExample.User", "gluon:Elixir.GluonExample.Tweet"]
  end

  def get(_params) do
    {:ok, [1, 2, 3]}
  end
end
