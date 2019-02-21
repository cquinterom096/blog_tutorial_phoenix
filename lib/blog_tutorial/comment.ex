defmodule BlogTutorial.Comment do
  use Ecto.Schema
  import Ecto.Changeset

  @derive {Jason.Encoder, only: [:content, :user]}

  schema "comments" do
    field :content, :string
    belongs_to :user, BlogTutorial.User
    belongs_to :topic, BlogTutorial.Topic
    field :inserted_at, :naive_datetime
    field :updated_at, :naive_datetime
  end

  @doc false
  def changeset(comment, attrs \\ %{}) do
    comment
    |> cast(attrs, [:content, :inserted_at, :updated_at])
    |> validate_required([:content])
  end
end