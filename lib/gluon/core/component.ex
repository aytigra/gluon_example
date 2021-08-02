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

  def extract_attributes(resource) do
    resource
    |> Ash.Resource.Info.attributes()
    |> Enum.map(fn a ->
      type =
        a.type |> to_string() |> String.trim_leading("Elixir.Ash.Type.") |> Macro.underscore()

      %{name: a.name, type: type}
    end)
  end
end
