defmodule WebGraph.OrgResolver do
  alias Core.Org
  alias Core.Org.{Role, Session, User, Workspace}

  def list_groups(_, args, %{context: %{session: session}}) do
    case Org.list_groups(args, session) do
      {:ok, groups} ->
        {:ok, groups}

      _ ->
        {:ok, []}
    end
  end

  @spec list_roles(map(), map(), Session.t()) :: {:ok, [%Role{}, ...]} | {:ok, nil}
  def list_roles(_, _args, %{context: %{session: session}}) do
    case Org.list_roles(session) do
      {:ok, roles} ->
        {:ok, roles}

      _ ->
        {:ok, []}
    end
  end

  @spec list_users(map(), map(), Session.t()) :: {:ok, [%User{}, ...]} | {:ok, nil}
  def list_users(_, args, %{context: %{session: session}}) do
    case Org.list_users(args, session) do
      {:ok, users} ->
        {:ok, users}

      _ ->
        {:ok, []}
    end
  end

  @spec list_workspaces(map(), map(), Session.t()) :: {:ok, [%Workspace{}, ...]} | {:ok, nil}
  def list_workspaces(_, args, %{context: %{session: session}}) do
    case Org.list_workspaces(args, session) do
      {:ok, workspaces} ->
        {:ok, workspaces}

      _ ->
        {:ok, []}
    end
  end

  ############
  ### Gets ###
  ############
  def get_tenant(_, _, %{context: %{session: session}}) do
    case Org.get_tenant(session) do
      {:ok, tenant} ->
        {:ok, tenant}

      _ ->
        {:ok, nil}
    end
  end

  def get_agent(_, %{id: id}, %{context: %{session: session}}) do
    case Org.get_agent(id, session) do
      {:ok, user} ->
        {:ok, user}

      _ ->
        {:ok, nil}
    end
  end

  def get_contact(_, %{id: id}, %{context: %{session: session}}) do
    case Org.get_contact(id, session) do
      {:ok, user} ->
        {:ok, user}

      _ ->
        {:ok, nil}
    end
  end

  def get_group(_, %{id: id}, %{context: %{session: session}}) do
    case Org.get_group(id, session) do
      {:ok, group} ->
        {:ok, group}

      _ ->
        {:ok, nil}
    end
  end

  def get_me(_, _args, %{context: %{session: %{id: _} = session}}) do
    me = %{
      name: session.name,
      permissions: session.permissions,
      type: session.type,
      id: session.user_id
    }

    {:ok, me}
  end

  def get_me(_, _args, _context) do
    {:ok, nil}
  end

  def get_role(_, %{id: id}, %{context: %{session: session}}) do
    case Org.get_role(id, session) do
      {:ok, role} ->
        {:ok, role}

      _ ->
        {:ok, nil}
    end
  end

  def get_user(_, %{id: id}, %{context: %{session: session}}) do
    case Org.get_user(id, session) do
      {:ok, user} ->
        {:ok, user}

      _ ->
        {:ok, nil}
    end
  end

  def get_workspace(_, %{id: id}, %{context: %{session: session}}) do
    case Org.get_workspace(id, session) do
      {:ok, workspace} ->
        {:ok, workspace}

      _ ->
        {:ok, nil}
    end
  end

  ###############
  ### Creates ###
  ###############
  def create_agent(_, %{input: attrs}, %{context: %{session: session}}) do
    case Org.create_agent(attrs, session) do
      {:ok, user} ->
        {:ok, %{user: user, errors: []}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  def create_agent_group(_, %{input: attrs}, %{context: %{session: session}}) do
    case Org.create_agent_group(attrs, session) do
      {:ok, group} ->
        {:ok, %{group: group}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  def create_contact(_, %{input: attrs}, %{context: %{session: session}}) do
    case Org.create_contact(attrs, session) do
      {:ok, user} ->
        {:ok, %{user: user}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  def create_contact_group(_, %{input: attrs}, %{context: %{session: session}}) do
    case Org.create_contact_group(attrs, session) do
      {:ok, group} ->
        {:ok, %{group: group}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  def create_role(_, %{input: attrs}, %{context: %{session: session}}) do
    case Org.create_role(attrs, session) do
      {:ok, role} ->
        {:ok, %{role: role}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end
  def create_workspace(_, %{input: attrs}, %{context: %{session: session}}) do
    case Org.create_workspace(attrs, session) do
      {:ok, workspace} ->
        {:ok, %{workspace: workspace, responses: [%{message: workspace.name <> " created"}]}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  ###############
  ### Enables ###
  ###############
  def enable_tenant(_, _, %{context: %{session: session}}) do
    case Org.enable_tenant(session) do
      {:ok, tenant} ->
        {:ok, %{tenant: tenant}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  def enable_agent(_, %{input: %{id: id}}, %{context: %{session: session}}) do
    case Org.enable_agent(id, session) do
      {:ok, user} ->
        {:ok, %{user: user}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  def enable_agent_group(_, %{input: %{id: id}}, %{context: %{session: session}}) do
    case Org.enable_agent_group(id, session) do
      {:ok, group} ->
        {:ok, %{group: group}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  def enable_contact(_, %{input: %{id: id}}, %{context: %{session: session}}) do
    case Org.enable_contact(id, session) do
      {:ok, user} ->
        {:ok, %{user: user}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  def enable_contact_group(_, %{input: %{id: id}}, %{context: %{session: session}}) do
    case Org.enable_contact_group(id, session) do
      {:ok, group} ->
        {:ok, %{group: group}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  def enable_workspace(_, %{input: %{id: id}}, %{context: %{session: session}}) do
    case Org.enable_workspace(id, session) do
      {:ok, workspace} ->
        {:ok, %{workspace: workspace, responses: [%{message: workspace.name <> " enabled"}]}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  ###############
  ### Deletes ###
  ###############
  def delete_tenant(_, _, %{context: %{session: session}}) do
    case Org.delete_tenant(session) do
      {:ok, tenant} ->
        {:ok, %{tenant: tenant}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  def delete_agent(_, %{input: %{id: id}}, %{context: %{session: session}}) do
    case Org.delete_agent(id, session) do
      {:ok, user} ->
        {:ok, %{user: user}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  def delete_agent_group(_, %{input: %{id: id}}, %{context: %{session: session}}) do
    case Org.delete_agent_group(id, session) do
      {:ok, group} ->
        {:ok, %{group: group}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  def delete_contact(_, %{input: %{id: id}}, %{context: %{session: session}}) do
    case Org.delete_contact(id, session) do
      {:ok, user} ->
        {:ok, %{user: user}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  def delete_contact_group(_, %{input: %{id: id}}, %{context: %{session: session}}) do
    case Org.delete_contact_group(id, session) do
      {:ok, group} ->
        {:ok, %{group: group}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  def delete_role(_, %{input: %{id: id}}, %{context: %{session: session}}) do
    case Org.delete_role(id, session) do
      {:ok, role} ->
        {:ok, %{role: role}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  def delete_workspace(_, %{input: %{id: id}}, %{context: %{session: session}}) do
    case Org.delete_workspace(id, session) do
      {:ok, workspace} ->
        {:ok, %{workspace: workspace, responses: [%{message: workspace.name <> " deleted"}]}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  ################
  ### Disables ###
  ################
  def disable_agent(_, %{input: %{id: id}}, %{context: %{session: session}}) do
    case Org.disable_agent(id, session) do
      {:ok, user} ->
        {:ok, %{user: user}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  def disable_agent_group(_, %{input: %{id: id}}, %{context: %{session: session}}) do
    case Org.disable_agent_group(id, session) do
      {:ok, group} ->
        {:ok, %{group: group}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  def disable_contact(_, %{input: %{id: id}}, %{context: %{session: session}}) do
    case Org.disable_contact(id, session) do
      {:ok, user} ->
        {:ok, %{user: user}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  def disable_contact_group(_, %{input: %{id: id}}, %{context: %{session: session}}) do
    case Org.disable_contact_group(id, session) do
      {:ok, group} ->
        {:ok, %{group: group}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  def disable_workspace(_, %{input: %{id: id}}, %{context: %{session: session}}) do
    case Org.disable_workspace(id, session) do
      {:ok, workspace} ->
        {:ok, %{workspace: workspace, responses: [%{message: workspace.name <> " disabled"}]}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  ###############
  ### Updates ###
  ###############
  def update_tenant(_, %{input: attrs}, %{context: %{session: session}}) do
    case Org.update_tenant(attrs, session) do
      {:ok, tenant} ->
        {:ok, %{tenant: tenant}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  def update_agent(_, %{input: attrs}, %{context: %{session: session}}) do
    case Org.update_agent(attrs, session) do
      {:ok, user} ->
        {:ok, %{user: user}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  def update_agent_group(_, %{input: attrs}, %{context: %{session: session}}) do
    case Org.update_agent_group(attrs, session) do
      {:ok, group} ->
        {:ok, %{group: group}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  def update_contact(_, %{input: attrs}, %{context: %{session: session}}) do
    case Org.update_contact(attrs, session) do
      {:ok, user} ->
        {:ok, %{user: user}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  def update_contact_group(_, %{input: attrs}, %{context: %{session: session}}) do
    case Org.update_contact_group(attrs, session) do
      {:ok, group} ->
        {:ok, %{group: group}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  def update_role(_, %{input: attrs}, %{context: %{session: session}}) do
    case Org.update_role(attrs, session) do
      {:ok, role} ->
        {:ok, %{role: role}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end

  def update_workspace(_, %{input: attrs}, %{context: %{session: session}}) do
    case Org.update_workspace(attrs, session) do
      {:ok, workspace} ->
        {:ok, %{workspace: workspace, responses: [%{message: workspace.name <> " updated"}]}}


      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end
end
