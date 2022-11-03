defmodule DrAdminWeb.ClinicLive.FormComponent do
  use DrAdminWeb, :live_component

  alias DrAdmin.Main

  @impl true
  def update(%{clinic: clinic} = assigns, socket) do
    changeset = Main.change_clinic(clinic)

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)}
  end

  @impl true
  def handle_event("validate", %{"clinic" => clinic_params}, socket) do
    changeset =
      socket.assigns.clinic
      |> Main.change_clinic(clinic_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"clinic" => clinic_params}, socket) do
    save_clinic(socket, socket.assigns.action, clinic_params)
  end

  defp save_clinic(socket, :edit, clinic_params) do
    case Main.update_clinic(socket.assigns.clinic, clinic_params) do
      {:ok, _clinic} ->
        {:noreply,
         socket
         |> put_flash(:info, "Clinic updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_clinic(socket, :new, clinic_params) do
    case Main.create_clinic(clinic_params) do
      {:ok, _clinic} ->
        {:noreply,
         socket
         |> put_flash(:info, "Clinic created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
