defmodule DrAdmin.Repo do
  use Ecto.Repo,
    otp_app: :dr_admin,
    adapter: Ecto.Adapters.Postgres
end
