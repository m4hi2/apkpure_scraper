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

  def app_page(document) do
    app_name =
      document
      |> Floki.find(".title-like")
      |> Floki.text()
      |> String.trim()

    author =
      document
      |> Floki.find(".details-author")
      |> Floki.text()
      |> String.trim()

    category =
      document
      |> Floki.find(".additional li:nth-child(1) span")
      |> tl()
      |> Floki.text()
      |> String.trim()

    version =
      document
      |> Floki.find(".additional li:nth-child(2) p")
      |> tl()
      |> Floki.text()
      |> String.trim()

    playstore_link =
      document
      |> Floki.attribute(".additional li:nth-child(5) a", "href")
      |> Floki.text()
      |> String.trim()

    app_description =
      document
      |> Floki.find(".description .content")
      |> Floki.text()
      |> String.trim()

    app_icon =
      document
      |> Floki.attribute(".icon img", "src")
      |> Floki.text()

    images =
      document
      |> Floki.attribute(".amagnificpopup img", "src")

    %{
      app_name: app_name,
      author: author,
      category: category,
      version: version,
      playstore_link: playstore_link,
      app_description: app_description,
      app_icon: app_icon,
      images: images
    }
  end
end
