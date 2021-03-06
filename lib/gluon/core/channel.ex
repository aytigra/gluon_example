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
      {:ok, resp} ->
        socket =
          if method_name == "data" do
            assign(socket, %{params: payload})
          else
            socket
          end

        {:reply, {:ok, resp}, socket}

      {:error, msg} ->
        {:reply, {:error, %{reason: msg}}, socket}
    end
  end

  intercept ["data_changed"]
  @impl true
  def handle_out("data_changed", _msg, socket) do
    unless socket.assigns[:no_updates] do
      {:ok, resp} = call_module(socket, "data", socket.assigns.params)
      push(socket, "data_changed", %{data: resp})
    end

    {:noreply, socket}
  end

  @impl true
  def handle_info(%Broadcast{topic: _, event: "changed", payload: payload}, socket) do
    broadcast(socket, "data_changed", payload)
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
