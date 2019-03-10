defmodule Twitter.Helpers do
  def current_user(conn), do: TwitterWeb.Router.current_resource(conn)
  
  def logged_in?(conn) do
    case TwitterWeb.Router.current_resource(conn) do
      nil -> false
      _ -> true
    end
  end
end
