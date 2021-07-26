defmodule Gluon.Component do
  @callback subscribe_to() :: [String.t()]
  @callback data(params :: map) ::
              {:ok, data :: map}
              | {:error, reason :: String.t()}

  defmacro __using__(opts \\ []) do
    quote do
      opts = unquote(opts)
      @behaviour unquote(__MODULE__)

      import unquote(__MODULE__)
    end
  end
end
