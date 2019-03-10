defmodule Twitter.Tweets.Tweet do
  use Ecto.Schema
  import Ecto.Changeset

  alias Twitter.Accounts.User

  schema "tweets" do
    field :tweet, :string

    belongs_to :user, User

    timestamps()
  end

  @doc false
  def changeset(tweet, attrs) do
    tweet
    |> cast(attrs, [:tweet, :user_id])
    |> validate_required([:tweet, :user_id])
    |> assoc_constraint(:user)
  end
end
