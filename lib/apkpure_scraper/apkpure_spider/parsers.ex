defmodule ApkpureScraper.ApkpureSpider.Parsers do
  def main_sitemap(document) do
    document
    |> Floki.find("loc")
    |> Enum.filter(fn {_, _, [url]} ->
      !String.contains?(url, ["group", "default", "tag", "topics"])
    end)
    |> Enum.map(fn {_, [], [url]} -> url end)
    |> Enum.uniq()
    |> Enum.map(&Crawly.Utils.request_from_url/1)
  end

  def category_sitemap(data) do
    data
    |> :zlib.gunzip()
    |> Floki.parse_document()
    |> elem(1)
    |> Floki.find("loc")
    |> Enum.filter(fn {filter, [], _} -> !String.contains?(filter, "image:loc") end)
    |> Enum.map(fn {_, [], [url]} -> url end)
    |> Enum.uniq()
    |> Enum.map(&Crawly.Utils.request_from_url/1)
  end
end