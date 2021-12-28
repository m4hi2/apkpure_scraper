defmodule ApkpureScraper.Apps.App do
  use Ecto.Schema
  import Ecto.Changeset

  schema "apps" do
    field :app_name, :string, null: false
    field :author, :string, null: false
    field :category, :string, null: false
    field :version, :string, null: false
    field :playstore_link, :string
    field :app_description, :string, null: false
    field :app_icon, :string, null: false
    field :images, {:array, :string}, null: false

    timestamps()
  end

  def changeset(apps, attrs \\ %{}) do
    apps
    |> cast(attrs, [
      :app_name,
      :author,
      :category,
      :version,
      :playstore_link,
      :app_description,
      :app_icon,
      :images
  ])

  end
end
