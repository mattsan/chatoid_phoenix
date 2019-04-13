defmodule ExChatoidWeb.PostController do
  use ExChatoidWeb, :controller

  alias ExChatoid.Chat

  def index(conn, _params) do
    posts = Chat.list_posts()
    render(conn, "index.json", posts: posts)
  end
end
