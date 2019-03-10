defmodule Twitter.Repo.Migrations.CreateTweets do
  use Ecto.Migration

  def change do
    create table(:tweets) do
      add :tweet, :text
      add :user_id, references(:users, on_delete: :delete_all)

      timestamps()
    end
  end
end
