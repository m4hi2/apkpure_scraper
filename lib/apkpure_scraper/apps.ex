defmodule ApkpureScraper.Apps do
  import Ecto.Query, warn: false

  alias ApkpureScraper.Repo
  alias ApkpureScraper.Apps.App

  def filter_only_with_play_link() do
    App
    |> app_playstore_link_query()
    |> Repo.all()
  end

  defp app_playstore_link_query(query) do
    from(a in query, where: not is_nil(a.playstore_link))
  end
end
