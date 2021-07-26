defmodule Gluon.AshNotifier do
  use Ash.Notifier

  def notify(%Ash.Notifier.Notification{resource: resource, action: %{type: _any}, actor: _actor}) do
    resource = resource |> to_string() |> String.trim_leading("Elixir.")
    GluonExampleWeb.Endpoint.broadcast!("gluon:#{resource}", "changed", %{})
  end
end
