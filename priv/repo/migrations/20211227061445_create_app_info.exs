defmodule ApkpureScraper.Repo.Migrations.CreateAppInfo do
  use Ecto.Migration

  def change do
    create table(:apps) do
      add :app_name, :string, null: false
      add :author, :string
      add :category, :string
      add :version, :string
      add :playstore_link, :string
      add :app_description, :text
      add :app_icon, :string
      add :images, {:array, :string}

      timestamps()
    end

  end
end
