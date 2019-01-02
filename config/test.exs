use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :web_graph, WebGraph.Endpoint,
  http: [port: 4002],
  server: false,
  secret_key_base: System.get_env("DEV_SECREY_KEY_BASE")

config :core, Core.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("DEV_DB_USERNAME"),
  password: System.get_env("DEV_DB_PASSWORD"),
  database: System.get_env("DEV_DB"),
  hostname: System.get_env("DEV_DB_HOST"),
  pool: Ecto.Adapters.SQL.Sandbox
