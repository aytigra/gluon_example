defmodule Gluon.Core.Channel do
  use Phoenix.Channel

  alias Phoenix.Socket.Broadcast

  @impl true
  def join("gluon:" <> _module_name, _params, socket) do
    subscribe_to_updates(socket)

    {:ok, socket}
  end

  @impl true
  def handle_in(method_name, payload, socket) do
    case call_module(socket, method_name, payload) do
      {:ok, resp} -> {:reply, {:ok, resp}, socket}
      {:error, msg} -> {:error, %{reason: msg}}
    end
  end

  intercept ["update"]
  @impl true
  def handle_out("update", _msg, socket) do
    unless socket.assigns[:no_updates] do
      {:ok, resp} = call_module(socket, "data", %{})
      push(socket, "update", %{data: resp})
    end

    {:noreply, socket}
  end

  @impl true
  def handle_info(%Broadcast{topic: _, event: "changed", payload: payload}, socket) do
    broadcast(socket, "update", payload)
    {:noreply, socket}
  end

  defp call_module(socket, method_name, params) do
    apply(module(socket), String.to_atom(method_name), [params])
  end

  defp subscribe_to_updates(socket) do
    apply(module(socket), :subscribe_to, [])
    |> Enum.each(fn topic ->
      :ok = socket.endpoint.subscribe(topic)
    end)
  end

  defp module(%{topic: "gluon:" <> module_name}) do
    String.to_existing_atom("Elixir.GluonExample.Components.#{module_name}")
  end
end
