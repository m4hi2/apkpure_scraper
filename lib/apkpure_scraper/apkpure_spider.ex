defmodule ApkpureScraper.ApkpureSpider do
  use Crawly.Spider

  @impl Crawly.Spider
  def base_url(), do: "https://apkpure.com"

  @impl Crawly.Spider
  def init(), do: [start_urls: ["https://apkpure.com/sitemap.xml"]]

  @impl Crawly.Spider
  def parse_item(response) do
    url = response.request_url

    case url do
      "https://apkpure.com/sitemap.xml" ->
        {:ok, document} = Floki.parse_document(response.body)

        requests =
          document
          |> Floki.find("loc")
          |> Enum.filter(fn {_, _, [url]} ->
            !String.contains?(url, ["group", "default", "tag", "topics"])
          end)
          |> Enum.map(fn {_, [], [url]} -> url end)
          |> Enum.uniq()
          |> Enum.map(&Crawly.Utils.request_from_url/1)

        %Crawly.ParsedItem{items: [%{gg: "gg"}], requests: requests}

      _anything_else ->
        case String.contains?(url, ".xml.gz") do
          true ->
            requests =
              response.body
              |> :zlib.gunzip()
              |> Floki.parse_document()
              |> elem(1)
              |> Floki.find("loc")
              |> Enum.filter(fn {filter, [], _} -> !String.contains?(filter, "image:loc") end)
              |> Enum.map(fn {_, [], [url]} -> url end)
              |> Enum.uniq()
              |> Enum.map(&Crawly.Utils.request_from_url/1)

            %Crawly.ParsedItem{items: [%{gg: "gg"}], requests: requests}

          _anything_else ->
            {:ok, document} = Floki.parse_document(response.body)

            app_name =
              document
              |> Floki.find(".title-like")
              |> Floki.text()

            author =
              document
              |> Floki.find(".details-author")
              |> Floki.text()

            category =
              document
              |> Floki.find(".additional li:nth-child(1) span")
              |> tl()
              |> Floki.text()

            version =
              document
              |> Floki.find(".additional li:nth-child(2) p")
              |> tl()
              |> Floki.text()

            playstore_link =
              document
              |> Floki.attribute(".additional li:nth-child(5) a", "href" )
              |> Floki.text

            item = %{app_name: app_name, author: author, category: category, version: version, playstore_link: playstore_link}

            %Crawly.ParsedItem{items: [item], requests: []}
        end
    end
  end
end
