defmodule DrAdmin.Repo.Migrations.CreateClinics do
  use Ecto.Migration

  def change do
    create table(:clinics) do
      add :name, :string
      add :address, :string
      add :phone_number, :string

      timestamps()
    end
  end
end
