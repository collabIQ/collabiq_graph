use Mix.Config

# We don't run a server during test. If one is required,
# you can enable the server option below.
config :web_graph, WebGraph.Endpoint,
  http: [port: 4001],
  server: false

config :logger, level: :warn

config :core, Core.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("TEST_DB_USERNAME"),
  password: System.get_env("TEST_DB_PASSWORD"),
  database: System.get_env("TEST_DB"),
  hostname: System.get_env("TEST_DB_HOST"),
  pool: Ecto.Adapters.SQL.Sandbox
