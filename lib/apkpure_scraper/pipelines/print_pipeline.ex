defmodule ApkpureScraper.Pipelines.PrintConsole do
  @behaviour Crawly.Pipeline

  @impl Crawly.Pipeline
  def run(item, state, _opts \\ []) do
    IO.inspect(item.app_name)

    {item, state}
  end
end
