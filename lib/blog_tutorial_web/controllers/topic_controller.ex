defmodule BlogTutorialWeb.TopicController do
  use BlogTutorialWeb, :controller

  alias BlogTutorial.Topic
  alias BlogTutorial.Repo

  plug BlogTutorialWeb.Plugs.RequireAuth when action in [:new, :create, :edit, :update, :delete]
  plug :check_topic_owner when action in [:edit, :update, :delete]

  def index(conn, _params) do
    topics = Repo.all(Topic)
    render(conn, "index.html", topics: topics)
  end

  def new(conn, _params) do
    changeset = Topic.changeset(%Topic{}, %{})

    render(conn, "new.html", changeset: changeset) # explicito me gusta, no poner extensiones embeded como eex o erb
  end

  def create(conn, %{ "topic" => topic }) do
    #changeset = Topic.changeset(%Topic{}, topic) form normal

    # Form con autenticacion en la conexion estamos guardando el user (SET_USER MODULE)
    changeset = conn.assigns.user
      |> Ecto.build_assoc(:topics)
      |> Topic.changeset(topic)

    case Repo.insert(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Topic created succesfully")
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, changeset} -> #podemos usar el metodod conn |> put_flash(:error, message) |> render(new.html, changeset)
        render(conn, "new.html", changeset: changeset)
    end
  end

  def edit(conn, %{ "id" => topic_id }) do
    topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(topic)

    render(conn, "edit.html", changeset: changeset, topic: topic)
  end

  def show(conn, %{"id" => topic_id}) do
    topic = Repo.get!(Topic, topic_id)

    render conn, "show.html", topic: topic
  end

  def update(conn, %{"id" => topic_id, "topic" => topic}) do
    old_topic = Repo.get(Topic, topic_id)
    changeset = Topic.changeset(old_topic, topic)

    case Repo.update(changeset) do
      {:ok, _topic} ->
        conn
        |> put_flash(:info, "Updated Record")
        |> redirect(to: Routes.topic_path(conn, :index))
      {:error, changeset} ->
        render(conn, "edit.html", changeset: changeset, topic: old_topic)
    end
  end

  def delete(conn, %{"id" => topic_id}) do
    Repo.get!(Topic, topic_id) |> Repo.delete!

    conn
    |> put_flash(:info, "Deleted Correctly the topic")
    |> redirect(to: Routes.topic_path(conn, :index))
  end

  defp check_topic_owner(conn, _params) do
    %{ params: %{ "id" => topic_id }} = conn

    if Repo.get(Topic, topic_id).user_id == conn.assigns.user.id do
      conn
    else
      conn
      |> put_flash(:error, "You cannot edit that")
      |> redirect(to: Routes.topic_path(conn, :index))
      |> halt()
    end
  end
end