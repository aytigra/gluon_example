defmodule GluonExample.Repo do
  use Ecto.Repo,
    otp_app: :gluon_example,
    adapter: Ecto.Adapters.Postgres
end
