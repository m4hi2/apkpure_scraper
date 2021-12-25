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

            item = ApkpureScraper.ApkpureSpider.Parsers.app_page(document)

            %Crawly.ParsedItem{items: [item], requests: []}
        end
    end
  end
end
