defmodule WebGraph.AuthResolver do
  alias Core.Security.LoginLocal
  alias Phoenix.Token
  alias WebGraph.Endpoint

  @user_salt "4C1yLc1v"

  def login(_, args, _) do
    with {:ok, session} <- LoginLocal.login(args),
         token <- sign(session) do
      {:ok, %{token: token}}
    else
      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  def sign(%{id: session_id}) do
    Token.sign(Endpoint, @user_salt, session_id, max_age: 2_592_000)
  end
end
