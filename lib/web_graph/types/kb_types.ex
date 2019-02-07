defmodule WebGraph.KbTypes do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers
  alias Core.Kb.{Article}
  alias WebGraph.KbResolver

  ###############
  ### Queries ###
  ###############
  object :kb_queries do
    field :articles, list_of(:article) do
      arg(:admin, :boolean, default_value: false)
      arg(:filter, :article_filter_input)
      arg(:sort, :sort_input)
      resolve(&KbResolver.list_articles/3)
    end
  end

  #################
  ### Mutations ###
  #################
  object :kb_mutations do
    field :create_article, :article_input_result do
      arg(:input, non_null(:article_input))
      resolve(&KbResolver.create_article/3)
    end
  end

  #############################
  ### Input Objects / Enums ###
  #############################
  input_object :article_filter_input do
    field(:name, :string)
    field(:status, list_of(:string))
    field(:type, list_of(:string))
    field(:workspaces, list_of(:binary_id))
  end

  input_object :article_input do
    field(:id, :binary_id)
    field(:content, :string)
    field(:name, :string)
    field(:pinned, :boolean)
    field(:type, :string)
    field(:workspace_id, :binary_id)
  end

  #####################
  ### Input Results ###
  #####################
  object :article_input_result do
    field(:article, :article)
    field(:errors, list_of(:input_error))
  end

  ###############
  ### Objects ###
  ###############
  object :article do
    field(:id, :binary_id)
    field(:created_at, :datetime)
    field(:deleted_at, :datetime)
    field(:content, :string)
    field(:name, :string)
    field(:pinned, :boolean)
    field(:status, :string)
    field(:type, :string)
  end

end
