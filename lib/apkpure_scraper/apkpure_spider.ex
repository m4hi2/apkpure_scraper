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

        requests = ApkpureScraper.ApkpureSpider.Parsers.main_sitemap(document)

        %Crawly.ParsedItem{items: [], requests: requests}

      _anything_else ->
        case String.contains?(url, ".xml.gz") do
          true ->
            requests = ApkpureScraper.ApkpureSpider.Parsers.category_sitemap(response.body)

            %Crawly.ParsedItem{items: [], requests: requests}

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
              |> String.trim()

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
              |> Floki.text()

            app_description =
              document
              |> Floki.find(".description .content")
              |> Floki.text()

            app_icon =
              document
              |> Floki.attribute(".icon img", "src")
              |> Floki.text()

            images =
              document
              |> Floki.attribute(".amagnificpopup img", "src")

            item = %{
              app_name: app_name,
              author: author,
              category: category,
              version: version,
              playstore_link: playstore_link,
              app_description: app_description,
              app_icon: app_icon,
              images: images
            }

            %Crawly.ParsedItem{items: [item], requests: []}
        end
    end
  end
end
