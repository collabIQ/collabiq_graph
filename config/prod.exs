use Mix.Config

config :web_graph, WebGraph.Endpoint,
  http: [port: 4001],
  url: [host: "localhost", port: 4001]
  cache_static_manifest: "priv/static/cache_manifest.json",
  server: true,
  secret_key_base: System.get_env("PROD_SECRET_KEY_BASE")

config :core, Core.Repo,
  adapter: Ecto.Adapters.Postgres,
  username: System.get_env("PROD_DB_USERNAME"),
  password: System.get_env("PROD_DB_PASSWORD"),
  database: System.get_env("PROD_DB"),
  hostname: System.get_env("PROD_DB_HOST"),
  pool_size: 10
