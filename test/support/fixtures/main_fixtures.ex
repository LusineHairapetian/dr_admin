defmodule DrAdmin.MainFixtures do
  @moduledoc """
  This module defines test helpers for creating
  entities via the `DrAdmin.Main` context.
  """

  @doc """
  Generate a clinic.
  """
  def clinic_fixture(attrs \\ %{}) do
    {:ok, clinic} =
      attrs
      |> Enum.into(%{
        address: "some address",
        name: "some name",
        phone_number: "some phone_number"
      })
      |> DrAdmin.Main.create_clinic()

    clinic
  end

  @doc """
  Generate a practitioner.
  """
  def practitioner_fixture(attrs \\ %{}) do
    {:ok, practitioner} =
      attrs
      |> Enum.into(%{
        description: "some description",
        name: "some name",
        phone_number: "some phone_number",
        specialty: "some specialty"
      })
      |> DrAdmin.Main.create_practitioner()

    practitioner
  end
end
