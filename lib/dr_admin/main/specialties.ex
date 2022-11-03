defmodule DrAdmin.Main.Specialty do
  use Ecto.Schema
  import Ecto.Changeset

  schema "specialties" do
    field :name, :string

    has_many :practitioners, DrAdmin.Main.Practitioner

    timestamps()
  end
end
