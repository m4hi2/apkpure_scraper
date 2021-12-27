defmodule ApkpureScraper.Apps.App do
  use Ecto.Schema

  schema "apps" do
    field :app_name, :string, null: false
    field :author, :string, null: false
    field :category, :string, null: false
    field :version, :string, null: false
    field :playstore_link, :string
    field :app_description, :string, null: false
    field :app_icon, :string, null: false
    field :images, {:array, :string}, null: false
  end
end
