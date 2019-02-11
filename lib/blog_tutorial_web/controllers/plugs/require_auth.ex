defmodule BlogTutorialWeb.Plugs.RequireAuth do
  import Plug.Conn
  import Phoenix.Controller

  alias BlogTutorial.Repo
  alias BlogTutorial.User

  alias BlogTutorialWeb.Router.Helpers

  def init(_params), do: nil

  def call(conn, _params) do
    if conn.assigns[:user] do
      conn
    else
      conn
      |> put_flash(:info, "You must be logged in.")
      |> redirect(to: Helpers.topic_path(conn, :index))
      |> halt()
    end
  end
end