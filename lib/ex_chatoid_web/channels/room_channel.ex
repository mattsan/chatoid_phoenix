defmodule ExChatoidWeb.RoomChannel do
  use Phoenix.Channel

  alias ExChatoid.Chat

  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end

  def jion("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("post_item", %{"item" => item}, socket) do
    {:ok, post} = Chat.create_post(%{posted_at: NaiveDateTime.utc_now(), item: item})
    posted_at = post.posted_at |> DateTime.from_naive!("Etc/UTC") |> DateTime.to_unix(:millisecond)
    broadcast!(socket, "post_item", %{posted_at: posted_at, item: item})
    {:noreply, socket}
  end
end
