defmodule ExChatoid.Repo.Migrations.CreatePosts do
  use Ecto.Migration

  def change do
    create table(:posts) do
      add :item, :string
      add :posted_at, :naive_datetime

      timestamps()
    end

  end
end
