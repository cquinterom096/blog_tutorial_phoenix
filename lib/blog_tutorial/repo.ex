defmodule BlogTutorial.Repo do
  use Ecto.Repo,
    otp_app: :blog_tutorial,
    adapter: Ecto.Adapters.Postgres
end
