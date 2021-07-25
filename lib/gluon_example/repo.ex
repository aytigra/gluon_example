defmodule GluonExample.Repo do
  use AshPostgres.Repo,
    otp_app: :gluon_example,
    adapter: Ecto.Adapters.Postgres
end
