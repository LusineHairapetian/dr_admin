defmodule DrAdminWeb.ClinicLive.Show do
  use DrAdminWeb, :live_view

  alias DrAdmin.Main

  @impl true
  def mount(_params, _session, socket) do
    {:ok, socket}
  end

  @impl true
  def handle_params(%{"id" => id}, _, socket) do
    {:noreply,
     socket
     |> assign(:page_title, page_title(socket.assigns.live_action))
     |> assign(:clinic, Main.get_clinic!(id))}
  end

  defp page_title(:show), do: "Show Clinic"
  defp page_title(:edit), do: "Edit Clinic"
end
