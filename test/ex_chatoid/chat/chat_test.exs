defmodule ExChatoid.ChatTest do
  use ExChatoid.DataCase

  alias ExChatoid.Chat

  describe "posts" do
    alias ExChatoid.Chat.Post

    @valid_attrs %{item: "some item", posted_at: ~N[2010-04-17 14:00:00]}
    @update_attrs %{item: "some updated item", posted_at: ~N[2011-05-18 15:01:01]}
    @invalid_attrs %{item: nil, posted_at: nil}

    def post_fixture(attrs \\ %{}) do
      {:ok, post} =
        attrs
        |> Enum.into(@valid_attrs)
        |> Chat.create_post()

      post
    end

    test "list_posts/0 returns all posts" do
      post = post_fixture()
      assert Chat.list_posts() == [post]
    end

    test "get_post!/1 returns the post with given id" do
      post = post_fixture()
      assert Chat.get_post!(post.id) == post
    end

    test "create_post/1 with valid data creates a post" do
      assert {:ok, %Post{} = post} = Chat.create_post(@valid_attrs)
      assert post.item == "some item"
      assert post.posted_at == ~N[2010-04-17 14:00:00]
    end

    test "create_post/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = Chat.create_post(@invalid_attrs)
    end

    test "update_post/2 with valid data updates the post" do
      post = post_fixture()
      assert {:ok, %Post{} = post} = Chat.update_post(post, @update_attrs)
      assert post.item == "some updated item"
      assert post.posted_at == ~N[2011-05-18 15:01:01]
    end

    test "update_post/2 with invalid data returns error changeset" do
      post = post_fixture()
      assert {:error, %Ecto.Changeset{}} = Chat.update_post(post, @invalid_attrs)
      assert post == Chat.get_post!(post.id)
    end

    test "delete_post/1 deletes the post" do
      post = post_fixture()
      assert {:ok, %Post{}} = Chat.delete_post(post)
      assert_raise Ecto.NoResultsError, fn -> Chat.get_post!(post.id) end
    end

    test "change_post/1 returns a post changeset" do
      post = post_fixture()
      assert %Ecto.Changeset{} = Chat.change_post(post)
    end
  end
end
