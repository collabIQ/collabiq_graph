defmodule WebGraph.SessionPlug do
  import Plug.Conn
  alias Core.Error
  alias Core.Org.Session
  alias Phoenix.Token
  alias WebGraph.Endpoint

  @user_salt "4C1yLc1v"

  def init(opts) do
    opts
  end

  def call(conn, _) do
    with ["Bearer " <> token] <- get_req_header(conn, "authorization"),
         {:ok, session_id} <- verify(token),
         {:ok, session} <- Session.get_session(session_id),
         {:ok, session} <- Session.preload_session_user_info(session),
         {:ok, session} <- Session.format_session(session) do
      Absinthe.Plug.put_options(conn, context: %{session: session})
    else
      _ ->
        Absinthe.Plug.put_options(conn, context: %{session: %{}})
    end
  end

  def verify(token) do
    case Token.verify(Endpoint, @user_salt, token, max_age: 2_592_000) do
      {:ok, session_id} ->
        {:ok, session_id}

      _ ->
        {:error, Error.message({:token, :invalid})}
    end
  end
end
