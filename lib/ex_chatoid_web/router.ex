defmodule ExChatoidWeb.Router do
  use ExChatoidWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", ExChatoidWeb do
    pipe_through :browser

    get "/", PageController, :index
  end

  scope "/api", ExChatoidWeb do
    pipe_through :api

    get "/posts", PostController, :index
  end
end
