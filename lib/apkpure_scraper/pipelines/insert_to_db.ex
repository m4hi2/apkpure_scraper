defmodule ApkpureScraper.Pipelines.InsertToDB do
  @moduledoc """
  Pipeline to insert items to database.
  """
  @behaviour Crawly.Pipeline

  @impl Crawly.Pipeline
  def run(item, state, _opts \\ []) do
    %ApkpureScraper.Apps.App{}
    |> ApkpureScraper.Apps.App.changeset(item)
    |> ApkpureScraper.Repo.insert()

    {item, state}
  end
end
