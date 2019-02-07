defmodule WebGraph.KbResolver do
  alias Core.Kb
  alias Core.Kb.{Article}

  def list_articles(_, args, %{context: %{session: session}}) do
    case Kb.list_articles(args, session) do
      {:ok, articles} ->
        {:ok, articles}

      _ ->
        {:ok, []}
    end
  end

  ############
  ### Gets ###
  ############
  def get_article(_, %{id: id}, %{context: %{session: session}}) do
    case Kb.get_article(id, session) do
      {:ok, article} ->
        {:ok, article}

      _ ->
        {:ok, nil}
    end
  end

  ###############
  ### Creates ###
  ###############
  def create_article(_, %{input: attrs}, %{context: %{session: session}}) do
    case Kb.create_article(attrs, session) do
      {:ok, article} ->
        {:ok, %{article: article, responses: [%{message: article.name <> " created"}]}}

      {:error, errors} ->
        {:ok, %{errors: errors}}
    end
  end
end
