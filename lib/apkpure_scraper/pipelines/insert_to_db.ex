defmodule ApkpureScraper.Pipelines.InsertToDB do
  @moduledoc """
  Pipeline to insert items to database.
  """
  @behaviour Crawly.Pipeline

  alias ApkpureScraper.Apps

  @impl Crawly.Pipeline
  def run(item, state, _opts \\ []) do
    Apps.create_app(item)

    {item, state}
  end
end
