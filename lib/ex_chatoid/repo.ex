defmodule ExChatoid.Repo do
  use Ecto.Repo,
    otp_app: :ex_chatoid,
    adapter: Ecto.Adapters.Postgres
end
