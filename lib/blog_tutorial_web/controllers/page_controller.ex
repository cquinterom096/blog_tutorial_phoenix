defmodule BlogTutorialWeb.PageController do
  use BlogTutorialWeb, :controller

  def index(conn, _params) do
    render(conn, "index.html")
  end
end
