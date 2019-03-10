defmodule TwitterWeb.TweetControllerTest do
  use TwitterWeb.ConnCase

  alias Twitter.Tweets

  @create_attrs %{tweet: "some tweet", user_id: 42}
  @update_attrs %{tweet: "some updated tweet", user_id: 43}
  @invalid_attrs %{tweet: nil, user_id: nil}

  def fixture(:tweet) do
    {:ok, tweet} = Tweets.create_tweet(@create_attrs)
    tweet
  end

  describe "index" do
    test "lists all tweets", %{conn: conn} do
      conn = get(conn, Routes.tweet_path(conn, :index))
      assert html_response(conn, 200) =~ "Listing Tweets"
    end
  end

  describe "new tweet" do
    test "renders form", %{conn: conn} do
      conn = get(conn, Routes.tweet_path(conn, :new))
      assert html_response(conn, 200) =~ "New Tweet"
    end
  end

  describe "create tweet" do
    test "redirects to show when data is valid", %{conn: conn} do
      conn = post(conn, Routes.tweet_path(conn, :create), tweet: @create_attrs)

      assert %{id: id} = redirected_params(conn)
      assert redirected_to(conn) == Routes.tweet_path(conn, :show, id)

      conn = get(conn, Routes.tweet_path(conn, :show, id))
      assert html_response(conn, 200) =~ "Show Tweet"
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post(conn, Routes.tweet_path(conn, :create), tweet: @invalid_attrs)
      assert html_response(conn, 200) =~ "New Tweet"
    end
  end

  describe "edit tweet" do
    setup [:create_tweet]

    test "renders form for editing chosen tweet", %{conn: conn, tweet: tweet} do
      conn = get(conn, Routes.tweet_path(conn, :edit, tweet))
      assert html_response(conn, 200) =~ "Edit Tweet"
    end
  end

  describe "update tweet" do
    setup [:create_tweet]

    test "redirects when data is valid", %{conn: conn, tweet: tweet} do
      conn = put(conn, Routes.tweet_path(conn, :update, tweet), tweet: @update_attrs)
      assert redirected_to(conn) == Routes.tweet_path(conn, :show, tweet)

      conn = get(conn, Routes.tweet_path(conn, :show, tweet))
      assert html_response(conn, 200) =~ "some updated tweet"
    end

    test "renders errors when data is invalid", %{conn: conn, tweet: tweet} do
      conn = put(conn, Routes.tweet_path(conn, :update, tweet), tweet: @invalid_attrs)
      assert html_response(conn, 200) =~ "Edit Tweet"
    end
  end

  describe "delete tweet" do
    setup [:create_tweet]

    test "deletes chosen tweet", %{conn: conn, tweet: tweet} do
      conn = delete(conn, Routes.tweet_path(conn, :delete, tweet))
      assert redirected_to(conn) == Routes.tweet_path(conn, :index)

      assert_error_sent 404, fn ->
        get(conn, Routes.tweet_path(conn, :show, tweet))
      end
    end
  end

  defp create_tweet(_) do
    tweet = fixture(:tweet)
    {:ok, tweet: tweet}
  end
end
