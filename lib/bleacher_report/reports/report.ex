defmodule BleacherReport.Reports.Report do
  @moduledoc """
  the reports schema
  """
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:user_id, :string, []}
  schema "reports" do
    field :action, :string
    field :content_id, :string
    field :type, :string
    field :reaction_type, :string
  end

  def changeset(reaction, attrs) do
    reaction
    |> cast(attrs, [:user_id, :action, :content_id, :type, :reaction_type])
    |> validate_required([:user_id, :action, :content_id, :type, :reaction_type])
  end
end
