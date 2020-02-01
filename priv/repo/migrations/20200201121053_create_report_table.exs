defmodule BleacherReport.Repo.Migrations.CreateReportTable do
  use Ecto.Migration

  def change do
    create table(:reports, primary_key: false) do
      add :user_id, :string, primary_key: true
      add :action, :string
      add :content_id, :string
      add :type, :string
      add :reaction_type, :string
    end
  end
end
