defmodule ExChatoidWeb.PageController do
  use ExChatoidWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
