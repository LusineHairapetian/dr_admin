defmodule DrAdminWeb.PractitionerLive.Index do
  use DrAdminWeb, :live_view

  alias DrAdmin.Main
  alias DrAdmin.Main.Practitioner

  @impl true
  def mount(_params, _session, socket) do
    IO.inspect(connected?(socket), label: "CONNTECTION STATUS")
    Main.subscribe()
    {:ok, assign(socket, :practitioners, list_practitioners())}
  end

  @impl true
  def handle_info({Main, [:practitioner, _], _}, socket) do
    {:noreply, assign(socket, :practitioners, list_practitioners())}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Practitioner")
    |> assign(:practitioner, Main.get_practitioner!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Practitioner")
    |> assign(:practitioner, %Practitioner{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Practitioners")
    |> assign(:practitioner, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    practitioner = Main.get_practitioner!(id)
    {:ok, _} = Main.delete_practitioner(practitioner)

    {:noreply, assign(socket, :practitioners, list_practitioners())}
  end

  defp list_practitioners do
    Main.list_practitioners()
  end
end
