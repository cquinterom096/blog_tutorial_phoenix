defmodule BlogTutorialWeb.Plugs.SetUser do
  import Plug.Conn
  import Phoenix.Controller

  alias BlogTutorial.Repo
  alias BlogTutorial.User

  def init(_params) do
  end

  def call(conn, _params) do
    user_id = get_session(conn, :user_id) # extrae un objeto del conection

    cond do
      user = user_id && Repo.get(User, user_id) ->
        assign(conn, :user, user)
      true ->
        assign(conn, :user, nil)
    end
  end
end