defmodule WebGraph.AuthTypes do
  use Absinthe.Schema.Notation
  alias WebGraph.AuthResolver

  object :login_result do
    field(:token, :string)
    field(:errors, list_of(:input_error))
  end

  object :auth_mutations do
    field :login, :login_result do
      arg(:email, non_null(:string))
      arg(:password, non_null(:string))
      resolve(&AuthResolver.login/3)
    end
  end
end
