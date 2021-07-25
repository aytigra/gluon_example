defmodule Gluon.Components.Grid do
  def subscribe_to() do
    ["gluon:users"]
  end

  def get(_params) do
    {:ok, [1, 2, 3]}
  end
end
