defmodule ApkpureScraper.Repo do
  use Ecto.Repo,
    otp_app: :apkpure_scraper,
    adapter: Ecto.Adapters.Postgres
end
