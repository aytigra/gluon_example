# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :gluon_example,
  ecto_repos: [GluonExample.Repo]

# Configures the endpoint
config :gluon_example, GluonExampleWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "GUUaI0tZDMAcPTyrNCf6J+W2bBcEnZ6ve7DPZwM/2TmSCkz+Nj6FA2mkplHtZCBS",
  render_errors: [view: GluonExampleWeb.ErrorView, accepts: ~w(html json), layout: false],
  pubsub_server: GluonExample.PubSub,
  live_view: [signing_salt: "MZpvBrS8"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

config :mime, :types, %{
    "application/vnd.api+json" => ["json"]
  }

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
