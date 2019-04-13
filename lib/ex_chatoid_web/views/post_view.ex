defmodule ExChatoidWeb.PostView do
  use ExChatoidWeb, :view

  def render("index.json", %{posts: posts}) do
    %{data: render_many(posts, ExChatoidWeb.PostView, "post.json")}
  end

  def render("post.json", %{post: post}) do
    %{
      posted_at: post.posted_at |> DateTime.from_naive!("Etc/UTC") |> DateTime.to_unix(:millisecond),
      item: post.item
    }
  end
end
