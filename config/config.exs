# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :ex_chatoid,
  ecto_repos: [ExChatoid.Repo]

# Configures the endpoint
config :ex_chatoid, ExChatoidWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "yJzQBsllyCSjWnp0w9yRvpfRkorqGEj4JL6xeZHx/AI/sghQZ6djckE2D1RzqN62",
  render_errors: [view: ExChatoidWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: ExChatoid.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
