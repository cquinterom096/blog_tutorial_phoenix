defmodule BlogTutorialWeb.Router do
  use BlogTutorialWeb, :router

  pipeline :browser do
    plug :accepts, ["html"]
    plug :fetch_session
    plug :fetch_flash
    plug :protect_from_forgery
    plug :put_secure_browser_headers
    plug BlogTutorialWeb.Plugs.SetUser
  end

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BlogTutorialWeb do
    pipe_through :browser

    # get "/", TopicController, :index
    # get "/topics", TopicController, :index
    # get "/topics/new", TopicController, :new
    # post "/topics", TopicController, :create
    # get "/topics/:id/edit", TopicController, :edit
    # put "/topics/:id", TopicController, :update
    resources "/", TopicController
  end

  scope "/auth", BlogTutorialWeb do
    pipe_through :browser

    get "/signout", AuthController, :signout
    get "/:provider", AuthController, :request
    get "/:provider/callback", AuthController, :callback
  end

  # Other scopes may use custom stacks.
  # scope "/api", BlogTutorialWeb do
  #   pipe_through :api
  # end
end
