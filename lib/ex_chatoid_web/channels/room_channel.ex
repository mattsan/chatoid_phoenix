defmodule ExChatoidWeb.RoomChannel do
  use Phoenix.Channel

  def join("room:lobby", _message, socket) do
    {:ok, socket}
  end

  def jion("room:" <> _private_room_id, _params, _socket) do
    {:error, %{reason: "unauthorized"}}
  end

  def handle_in("post_item", %{"item" => item}, socket) do
    {:ok, posted_at} =  Timex.format(Timex.now("Asia/Tokyo"), "{YYYY}/{0M}/{0D} {h24}:{m}")
    broadcast!(socket, "post_item", %{posted_at: posted_at, item: item})
    {:noreply, socket}
  end
end
