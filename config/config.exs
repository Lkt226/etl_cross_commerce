# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :etl_cross_commerce,
  ecto_repos: [EtlCrossCommerce.Repo]

# Configures the endpoint
config :etl_cross_commerce, EtlCrossCommerceWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "YTewm+tB08U+k7FubSbERuzuCCd0R/75rElG1xlFAnxuee9KlymRLWitd9GZ3Ojm",
  render_errors: [view: EtlCrossCommerceWeb.ErrorView, accepts: ~w(json), layout: false],
  pubsub_server: EtlCrossCommerce.PubSub,
  live_view: [signing_salt: "YCLxnGXc"]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
