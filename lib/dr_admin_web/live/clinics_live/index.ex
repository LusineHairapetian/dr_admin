defmodule DrAdminWeb.ClinicLive.Index do
  use DrAdminWeb, :live_view

  alias DrAdmin.Main
  alias DrAdmin.Main.Clinic

  @impl true
  def mount(_params, _session, socket) do
    if connected?(socket), do: Main.subscribe()
    {:ok, assign(socket, :clinics, list_clinics())}
  end

  @impl true
  def handle_info({:clinic_created, result}, socket) do
    {:noreply, update(socket, :clinics, fn clinics -> [result | clinics] end)}
  end

  @impl true
  def handle_params(params, _url, socket) do
    {:noreply, apply_action(socket, socket.assigns.live_action, params)}
  end

  defp apply_action(socket, :edit, %{"id" => id}) do
    socket
    |> assign(:page_title, "Edit Clinic")
    |> assign(:clinic, Main.get_clinic!(id))
  end

  defp apply_action(socket, :new, _params) do
    socket
    |> assign(:page_title, "New Clinic")
    |> assign(:clinic, %Clinic{})
  end

  defp apply_action(socket, :index, _params) do
    socket
    |> assign(:page_title, "Listing Clinics")
    |> assign(:clinic, nil)
  end

  @impl true
  def handle_event("delete", %{"id" => id}, socket) do
    clinic = Main.get_clinic!(id)
    {:ok, _} = Main.delete_clinic(clinic)

    {:noreply, assign(socket, :clinics, list_clinics())}
  end

  defp list_clinics do
    Main.list_clinics()
  end
end
