defmodule Gluon.AshNotifier do
  use Ash.Notifier

  def notify(%Ash.Notifier.Notification{resource: resource, action: %{type: _any}, actor: _actor}) do
    GluonExampleWeb.Endpoint.broadcast!("gluon:#{resource}", "changed", %{})
  end
end
