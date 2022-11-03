defmodule DrAdmin.Main.Practitioner do
  use Ecto.Schema
  import Ecto.Changeset

  schema "practitioners" do
    field :description, :string
    field :name, :string
    field :phone_number, :string
    belongs_to :clinic, DrAdmin.Main.Clinic
    belongs_to :specialty, DrAdmin.Main.Specialty

    timestamps()
  end

  @phone_number_format ~r/^(0047|\+47|47)?\d{8}$/

  @doc false
  def changeset(practitioner, attrs) do
    practitioner
    |> cast(attrs, [:name, :phone_number, :specialty_id, :clinic_id, :description])
    |> validate_required([:name, :phone_number, :specialty_id, :clinic_id])
    |> validate_format(:phone_number, @phone_number_format, 
      message: "must be a valid Norwegian phone number")
  end
end
