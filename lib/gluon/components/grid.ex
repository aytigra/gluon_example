defmodule Gluon.Components.Grid do
  @callback sort() :: String.t()

  defmacro __using__(opts \\ []) do
    quote do
      opts = unquote(opts)
      @behaviour unquote(__MODULE__)

      import unquote(__MODULE__)
    end
  end
end
