defmodule DrAdmin.Repo.Migrations.CreatePractitioners do
  use Ecto.Migration

  def change do
    create table(:practitioners) do
      add :name, :string
      add :description, :string
      add :phone_number, :string
      add :clinic_id, references(:clinics, on_delete: :delete_all)
      add :specialty_id, references(:specialties, on_delete: :delete_all)

      timestamps()
    end

    create index(:practitioners, [:clinic_id])
    create index(:practitioners, [:specialty_id])

  end
end
