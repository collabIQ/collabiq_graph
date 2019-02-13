# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config
config :core, ecto_repos: [Core.Repo]

config :core, Core.UUID,
  salt: System.get_env("HASHID_SALT")

config :web_graph, ecto_repos: [Core.Repo]

# General application configuration
config :web_graph,
  namespace: WebGraph,
  ecto_repos: [Core.Repo]

# Configures the endpoint
config :web_graph, WebGraph.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "JbSS+mF2qR3w+3PdYK4g4uBwTA48ZGF6sHpkt0tynRf4EIyrMp0aPb1CAmMgkrkL",
  render_errors: [view: WebGraph.ErrorView, accepts: ~w(json)],
  pubsub: [name: WebGraph.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

config :web_graph, :generators,
  context_app: false

config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
