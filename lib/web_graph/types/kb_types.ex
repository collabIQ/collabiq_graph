defmodule WebGraph.KbTypes do
  use Absinthe.Schema.Notation
  import Absinthe.Resolution.Helpers
  alias Core.Kb.{Folder}
  alias Core.Org.{Group, User, Workspace}
  alias WebGraph.OrgResolver

  ###############
  ### Queries ###
  ###############


  #################
  ### Mutations ###
  #################


  #############################
  ### Input Objects / Enums ###
  #############################
  input_object :kb_sort_input do
    field(:field, :kb_sort_field, default_value: :name)
    field(:order, :sort_order, default_value: :asc)
  end

  enum :kb_sort_field do
    value(:created_at)
    value(:name)
    value(:updated_at)
  end

  #####################
  ### Input Results ###
  #####################


  ###############
  ### Objects ###
  ###############
  object :folder do
    field(:id, :binary_id)
    field(:created_at, :datetime)
    field(:name, :string)
    field(:parent_id, :string)
    field(:updated_at, :datetime)
  end


end
