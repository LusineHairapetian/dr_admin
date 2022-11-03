defmodule DrAdmin.Main.Clinic do
  use Ecto.Schema
  import Ecto.Changeset

  schema "clinics" do
    field :address, :string
    field :name, :string
    field :phone_number, :string

    has_many :practitioners, DrAdmin.Main.Practitioner

    timestamps()
  end

  @phone_number_format ~r/^(0047|\+47|47)?\d{8}$/

  @doc false
  def changeset(clinic, attrs) do
    clinic
    |> cast(attrs, [:name, :address, :phone_number])
    |> validate_required([:name, :address, :phone_number])
    |> validate_format(:phone_number, @phone_number_format, 
      message: "must be a valid Norwegian phone number")
  end
end
