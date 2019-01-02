defmodule WebGraph.Router do
  use WebGraph, :router

  pipeline :api do
    plug CORSPlug, origin: "*"
    plug :accepts, ["json"]
    plug(WebGraph.SessionPlug)
  end

  scope "/" do
    pipe_through(:api)

    forward("/graphql", Absinthe.Plug, schema: WebGraph.Schema)

    forward("/graphiql", Absinthe.Plug.GraphiQL, schema: WebGraph.Schema, socket: WebGraph.UserSocket)
  end
end
