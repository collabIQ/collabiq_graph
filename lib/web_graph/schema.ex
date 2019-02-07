defmodule WebGraph.Schema do
  use Absinthe.Schema
  alias Core.Data
  alias Core.Kb.{Folder}
  alias Core.Org.{Group, User, Workspace}

  def context(context) do
    default_params = Map.take(context, [:session])
    source = Data.dataloader(default_params)
    dataloader =
      Dataloader.new()
      |> Dataloader.add_source(Folder, source)
      |> Dataloader.add_source(Group, source)
      |> Dataloader.add_source(User, source)
      |> Dataloader.add_source(Workspace, source)

    Map.put(context, :loader, dataloader)
  end

  def plugins() do
    [Absinthe.Middleware.Dataloader | Absinthe.Plugin.defaults()]
  end

  import_types(Absinthe.Type.Custom)
  import_types(WebGraph.CustomTypes)
  import_types(WebGraph.AuthTypes)
  import_types(WebGraph.KbTypes)
  import_types(WebGraph.OrgTypes)

  subscription do
    import_fields(:org_subscriptions)
  end

  query do
    import_fields(:kb_queries)
    import_fields(:org_queries)
  end

  mutation do
    import_fields(:auth_mutations)
    import_fields(:kb_mutations)
    import_fields(:org_mutations)
  end

  object :input_error do
    field(:message, non_null(:string))
  end

  object :input_response do
    field(:message, non_null(:string))
  end

  input_object :sort_input do
    field(:field, :string)
    field(:order, :string)
  end

  enum :sort_order do
    value(:asc)
    value(:desc)
  end
end
