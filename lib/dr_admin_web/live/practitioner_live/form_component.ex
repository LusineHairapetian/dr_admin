defmodule DrAdminWeb.PractitionerLive.FormComponent do
  use DrAdminWeb, :live_component

  alias DrAdmin.Main

  @impl true
  def update(%{practitioner: practitioner} = assigns, socket) do
    changeset = Main.change_practitioner(practitioner)
    clinics = Main.list_clinics()
    specialties = Main.list_specialties()

    {:ok,
     socket
     |> assign(assigns)
     |> assign(:changeset, changeset)
     |> assign(:specialties, specialties)
     |> assign(:clinics, clinics)}
  end

  @impl true
  def handle_event("validate", %{"practitioner" => practitioner_params}, socket) do
    changeset =
      socket.assigns.practitioner
      |> Main.change_practitioner(practitioner_params)
      |> Map.put(:action, :validate)

    {:noreply, assign(socket, :changeset, changeset)}
  end

  def handle_event("save", %{"practitioner" => practitioner_params}, socket) do
    save_practitioner(socket, socket.assigns.action, practitioner_params)
  end

  defp save_practitioner(socket, :edit, practitioner_params) do
    case Main.update_practitioner(socket.assigns.practitioner, practitioner_params) do
      {:ok, _practitioner} ->
        {:noreply,
         socket
         |> put_flash(:info, "Practitioner updated successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, :changeset, changeset)}
    end
  end

  defp save_practitioner(socket, :new, practitioner_params) do
    case Main.create_practitioner(practitioner_params) do
      {:ok, _practitioner} ->
        {:noreply,
         socket
         |> put_flash(:info, "Practitioner created successfully")
         |> push_redirect(to: socket.assigns.return_to)}

      {:error, %Ecto.Changeset{} = changeset} ->
        {:noreply, assign(socket, changeset: changeset)}
    end
  end
end
