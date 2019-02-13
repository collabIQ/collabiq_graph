defmodule WebGraph.Test.ListWorkspaces do
  use WebGraph.ConnCase, async: true

  @query """
  {
    workspaces {
      name
    }
  }
  """

  test "list workspaces", %{conn: conn} do
    conn = conn |> auth_user()
    response =
      get(conn, "/graphql", query: @query)

    assert json_response(response, 200) == %{"data" => %{"workspaces" => [
      %{"name" => "WS1"},
      %{"name" => "WS2"}
    ]}}
  end

  @query """
  {
    workspaces(filter: {status: "active"}) {
      name
    }
  }
  """

  test "list active workspaces", %{conn: conn} do
    conn = conn |> auth_user()
    response =
      get(conn, "/graphql", query: @query)

    assert json_response(response, 200) == %{"data" => %{"workspaces" => [
      %{"name" => "WS1"},
      %{"name" => "WS2"}
    ]}}
  end

  @query """
  {
    workspaces(filter: {status: "disabled"}) {
      name
    }
  }
  """

  test "list disabled workspaces", %{conn: conn} do
    conn = conn |> auth_user()
    response =
      get(conn, "/graphql", query: @query)

    assert json_response(response, 200) == %{"data" => %{"workspaces" => []}}
  end

  @query """
  {
    workspaces(sort: {field: "name", order: "desc"}) {
      name
    }
  }
  """

  test "list workspaces sorted by name descending", %{conn: conn} do
    conn = conn |> auth_user()
    response =
      get(conn, "/graphql", query: @query)

    assert json_response(response, 200) == %{"data" => %{"workspaces" => [
      %{"name" => "WS2"},
      %{"name" => "WS1"}
    ]}}
  end

  @query """
  {
    workspaces(admin: true) {
      name
    }
  }
  """

  test "list workspaces with admin option", %{conn: conn} do
    conn = conn |> auth_user()
    response =
      get(conn, "/graphql", query: @query)

    assert json_response(response, 200) == %{"data" => %{"workspaces" => [
      %{"name" => "WS1"},
      %{"name" => "WS2"},
      %{"name" => "WS3"},
      %{"name" => "WS4"},
      %{"name" => "WS5"}
    ]}}
  end

  @query """
  {
    workspaces(admin: true, filter: {status: "active"}) {
      name
    }
  }
  """

  test "list active workspaces with admin option", %{conn: conn} do
    conn = conn |> auth_user()
    response =
      get(conn, "/graphql", query: @query)

    assert json_response(response, 200) == %{"data" => %{"workspaces" => [
      %{"name" => "WS1"},
      %{"name" => "WS2"},
      %{"name" => "WS3"},
      %{"name" => "WS5"}
    ]}}
  end

  @query """
  {
    workspaces(admin: true, filter: {status: "disabled"}) {
      name
    }
  }
  """

  test "list disabled workspaces with admin option", %{conn: conn} do
    conn = conn |> auth_user()
    response =
      get(conn, "/graphql", query: @query)

    assert json_response(response, 200) == %{"data" => %{"workspaces" => [
      %{"name" => "WS4"}
    ]}}
  end

  @query """
  {
    workspaces(admin: true, sort: {field: "name", order: "desc"}) {
      name
    }
  }
  """

  test "list workspaces sorted by name descending with admin option", %{conn: conn} do
    conn = conn |> auth_user()
    response =
      get(conn, "/graphql", query: @query)

    assert json_response(response, 200) == %{"data" => %{"workspaces" => [
      %{"name" => "WS5"},
      %{"name" => "WS4"},
      %{"name" => "WS3"},
      %{"name" => "WS2"},
      %{"name" => "WS1"}
    ]}}
  end

  defp auth_user(conn) do
    {:ok, session} = Core.Security.LoginLocal.login(%{email: "admin@email.com", password: "password"})
    token = WebGraph.AuthResolver.sign(session)

    put_req_header(conn, "authorization", "Bearer " <> token)
  end
end
