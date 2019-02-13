defmodule WebGraph.OrgTypes do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers
  alias Core.Kb.{Folder}
  alias Core.Org.{Group, User, Workspace}
  alias WebGraph.OrgResolver

  #####################
  ### Subscriptions ###
  #####################
  object :org_subscriptions do
    field :updated_workspace, :workspace do
      arg :id, non_null(:binary_id)

      config fn args, _info ->
        {:ok, topic: args.id}
      end

      trigger [:update_workspace],
      topic: fn
        %{workspace: workspace} ->
          [workspace.id]

        _ ->
          []
      end

      resolve fn %{workspace: workspace}, _, _ ->
        {:ok, workspace}
      end
    end
  end

  ###############
  ### Queries ###
  ###############
  object :org_queries do
    field :tenant, :tenant do
      resolve(&OrgResolver.get_tenant/3)
    end

    field :group, :group do
      arg(:id, non_null(:base_id))
      resolve(&OrgResolver.get_group/3)
    end

    field :groups, list_of(:group) do
      arg(:admin, :boolean)
      arg(:filter, :group_filter_input)
      arg(:sort, :sort_input)
      resolve(&OrgResolver.list_groups/3)
    end

    field(:me, :me) do
      resolve(&OrgResolver.get_me/3)
    end

    field :role, :role do
      arg(:id, non_null(:base_id))
      resolve(&OrgResolver.get_role/3)
    end

    field :roles, list_of(:role) do
      resolve(&OrgResolver.list_roles/3)
    end

    field :user, :user do
      arg(:id, non_null(:binary_id))
      resolve(&OrgResolver.get_user/3)
    end

    field :users, list_of(:user) do
      arg(:admin, :boolean)
      arg(:filter, :user_filter_input)
      arg(:sort, :sort_input)
      resolve(&OrgResolver.list_users/3)
    end

    field :workspace, :workspace do
      arg(:id, non_null(:base_id))
      resolve(&OrgResolver.get_workspace/3)
    end

    field :workspaces, list_of(:workspace) do
      arg(:admin, :boolean)
      arg(:filter, :workspace_filter_input)
      arg(:sort, :sort_input)
      resolve(&OrgResolver.list_workspaces/3)
    end
  end

  #################
  ### Mutations ###
  #################
  object :org_mutations do
    field :create_agent, :user_input_result do
      arg(:input, non_null(:user_input))
      resolve(&OrgResolver.create_agent/3)
    end

    field :create_agent_group, :group_input_result do
      arg(:input, non_null(:group_input))
      resolve(&OrgResolver.create_agent_group/3)
    end

    field :create_contact, :user_input_result do
      arg(:input, non_null(:user_input))
      resolve(&OrgResolver.create_contact/3)
    end

    field :create_contact_group, :group_input_result do
      arg(:input, non_null(:group_input))
      resolve(&OrgResolver.create_contact_group/3)
    end

    field :create_role, :role_input_result do
      arg(:input, non_null(:role_input))
      resolve(&OrgResolver.create_role/3)
    end

    field :create_workspace, :workspace_input_result do
      arg(:input, non_null(:workspace_input))
      resolve(&OrgResolver.create_workspace/3)
    end

    field :delete_tenant, :tenant_input_result do
      arg(:input, non_null(:tenant_input))
      resolve(&OrgResolver.delete_tenant/3)
    end

    field :delete_agent, :user_input_result do
      arg(:input, non_null(:user_input))
      resolve(&OrgResolver.delete_agent/3)
    end

    field :delete_agent_group, :group_input_result do
      arg(:input, non_null(:group_input))
      resolve(&OrgResolver.delete_agent_group/3)
    end

    field :delete_contact, :user_input_result do
      arg(:input, non_null(:user_input))
      resolve(&OrgResolver.delete_contact/3)
    end

    field :delete_contact_group, :group_input_result do
      arg(:input, non_null(:group_input))
      resolve(&OrgResolver.delete_contact_group/3)
    end

    field :delete_workspace, :workspace_input_result do
      arg(:input, non_null(:workspace_input))
      resolve(&OrgResolver.delete_workspace/3)
    end

    field :enable_tenant, :tenant_input_result do
      arg(:input, non_null(:tenant_input))
      resolve(&OrgResolver.enable_tenant/3)
    end

    field :enable_workspace, :workspace_input_result do
      arg(:input, non_null(:workspace_input))
      resolve(&OrgResolver.enable_workspace/3)
    end

    field :disable_workspace, :workspace_input_result do
      arg(:input, non_null(:workspace_input))
      resolve(&OrgResolver.disable_workspace/3)
    end

    field :update_tenant, :tenant_input_result do
      arg(:input, non_null(:tenant_input))
      resolve(&OrgResolver.update_tenant/3)
    end

    field :update_agent, :user_input_result do
      arg(:input, non_null(:user_input))
      resolve(&OrgResolver.update_agent/3)
    end

    field :update_agent_group, :group_input_result do
      arg(:input, non_null(:group_input))
      resolve(&OrgResolver.update_agent_group/3)
    end

    field :update_workspace, :workspace_input_result do
      arg(:input, non_null(:workspace_input))
      resolve(&OrgResolver.update_workspace/3)
    end
  end

  #############################
  ### Input Objects / Enums ###
  #############################
  input_object :tenant_input do
    field(:name, :string)
  end

  input_object :group_filter_input do
    field(:name, :string)
    field(:status, list_of(:string))
    field(:type, list_of(:string))
    field(:workspaces, list_of(:binary_id))
  end

  input_object :group_input do
    field(:id, :binary_id)
    field(:description, :string)
    field(:email, :string)
    field(:name, :string)
    field(:phone, :string)
    field(:users, list_of(:binary_id))
    field(:workspace_id, :binary_id)
  end

  input_object :org_filter_input do
    field(:name, :string)
    field(:status, :string)
  end

  input_object :org_sort_input do
    field(:field, :org_sort_field, default_value: :name)
    field(:order, :sort_order, default_value: :asc)
  end

  enum :org_sort_field do
    value(:created_at)
    value(:email)
    value(:name)
    value(:type)
    value(:updated_at)
  end

  input_object :permissions_input do
    field(:create_group, :integer)
    field(:create_user, :integer)
    field(:create_workspace, :integer)
    field(:update_tenant, :integer)
    field(:update_group, :integer)
    field(:update_role, :integer)
    field(:update_user, :integer)
    field(:update_workspace, :integer)
  end

  input_object :phone_input do
    field(:number, :string)
    field(:type, :string)
  end

  input_object :role_input do
    field(:id, :base_id)
    field(:name, :string)
    field(:permissions, :permissions_input)
    field(:type, :string)
  end

  input_object :user_filter_input do
    field(:name, :string)
    field(:status, list_of(:string))
    field(:type, list_of(:string))
    field(:workspaces, list_of(:base_id))
  end

  input_object :user_input do
    field(:id, :base_id)
    field(:address, :string)
    field(:groups, list_of(:binary_id))
    field(:email, :string)
    field(:language, :string)
    field(:mobile, :string)
    field(:name, :string)
    field(:phones, :string)
    field(:role_id, :binary_id)
    field(:timezone, :string)
    field(:title, :string)
    field(:workspaces, list_of(:binary_id))
  end

  input_object :workspace_filter_input do
    field(:name, :string)
    field(:status, list_of(:string))
  end

  input_object :workspace_input do
    field(:id, :base_id)
    field(:color, :string)
    field(:description, :string)
    field(:name, :string)
    field(:notes, :string)
  end

  #####################
  ### Input Results ###
  #####################
  object :tenant_input_result do
    field(:tenant, :tenant)
    field(:errors, list_of(:input_error))
  end

  object :group_input_result do
    field(:group, :group)
    field(:errors, list_of(:input_error))
  end

  object :role_input_result do
    field(:role, :role)
    field(:errors, list_of(:input_error))
  end

  object :user_input_result do
    field(:user, :user)
    field(:errors, list_of(:input_error))
  end

  object :workspace_input_result do
    field(:workspace, :workspace)
    field(:errors, list_of(:input_error))
    field(:responses, list_of(:input_response))
  end

  ###############
  ### Objects ###
  ###############
  object :tenant do
    field(:id, :binary_id)
    field(:created_at, :datetime)
    field(:deleted_at, :datetime)
    field(:name, :string)
    field(:status, :string)
    field(:updated_at, :datetime)
  end

  object :group do
    field(:id, :binary_id)
    field(:created_at, :datetime)
    field(:description, :string)
    field(:email, :string)
    field(:name, :string)
    field(:phone, :string)
    field(:status, :string)
    field(:type, :string)
    field(:updated_at, :datetime)

    field :users, list_of(:user) do
      arg(:filter, :org_filter_input)
      arg(:sort, :org_sort_input)
      resolve dataloader(User, :users, [])
    end

    field :workspace, :workspace do
      resolve dataloader(Workspace, :workspace)
    end
  end

  object :me do
    field(:id, :binary_id)
    field(:name, :string)
    field(:permissions, :permissions)
    field(:type, :string)
  end

  object :permissions do
    field(:c_ag, :integer)
    field(:c_agent, :integer)
    field(:c_art, :integer)
    field(:c_cg, :integer)
    field(:c_con, :integer)
    field(:c_tag, :integer)
    field(:c_ws, :integer)
    field(:m_role, :integer)
    field(:pub_art, :integer)
    field(:u_ag, :integer)
    field(:u_agent, :integer)
    field(:u_art, :integer)
    field(:u_cg, :integer)
    field(:u_con, :integer)
    field(:u_tag, :integer)
    field(:u_ten, :integer)
    field(:u_ws, :integer)
  end

  object :phone do
    field(:number, :string)
    field(:type, :string)
  end

  object :role do
    field(:id, :base_id)
    field(:created_at, :datetime)
    field(:name, :string)
    field(:permissions, :permissions)
    field(:type, :string)
    field(:updated_at, :datetime)
  end

  object :user do
    field(:id, :base_id)
    field(:address, :string)
    field(:created_at, :datetime)
    field(:deleted_at, :datetime)

    field :groups, list_of(:group) do
      arg(:filter, :org_filter_input)
      arg(:sort, :org_sort_input)
      resolve dataloader(Group, :groups, [])
    end

    field(:email, :string)
    field(:email_valid, :boolean)
    field(:language, :string)
    field(:mobile, :string)
    field(:name, :string)
    field(:phone, :string)
    field(:status, :string)
    field(:timezone, :string)
    field(:title, :string)
    field(:type, :string)
    field(:updated_at, :datetime)

    field :workspaces, list_of(:workspace) do
      arg(:filter, :org_filter_input)
      arg(:sort, :org_sort_input)
      resolve dataloader(Workspace, :workspaces, [])
    end
  end

  object :workspace do
    field(:id, :base_id)
    field(:color, :string)
    field(:created_at, :datetime)
    field(:deleted_at, :datetime)
    field(:description, :string)

    field :groups, list_of(:group) do
      arg(:filter, :group_filter_input)
      arg(:sort, :sort_input)
      resolve dataloader(Group, :groups)
    end

    field(:name, :string)
    field(:notes, :string)
    field(:status, :string)
    field(:updated_at, :datetime)

    field :users, list_of(:user) do
      arg(:filter, :org_filter_input)
      arg(:sort, :org_sort_input)
      resolve dataloader(User, :users, [])
    end
  end
end
