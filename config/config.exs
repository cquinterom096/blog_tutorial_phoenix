# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

config :blog_tutorial,
  ecto_repos: [BlogTutorial.Repo]

# Configures the endpoint
config :blog_tutorial, BlogTutorialWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "DVKTs1dUL2+60zpFZLLaPw5XB1XYM9g/byAj6A3MhXBxDreNKAwG2ecE2tUQ5z17",
  render_errors: [view: BlogTutorialWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: BlogTutorial.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"

config :ueberauth, Ueberauth,
  providers: [
    github: {Ueberauth.Strategy.Github, [default_scope: "user,user:email,public_repo"]}
  ]

config :ueberauth, Ueberauth.Strategy.Github.OAuth,
  client_id: "3ece3abdefce3c92bbc1",
  client_secret: "296dd476f4e5bfb822b39de36acb9525bfad46c2"