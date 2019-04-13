defmodule ExChatoid.Chat.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field :item, :string
    field :posted_at, :naive_datetime

    timestamps()
  end

  @doc false
  def changeset(post, attrs) do
    post
    |> cast(attrs, [:item, :posted_at])
    |> validate_required([:item, :posted_at])
  end
end
