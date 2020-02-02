defmodule BleacherReportWeb.BleacherReportView do
  use BleacherReportWeb, :view

  def render("reaction.json", %{reactions: reactions, content_id: content_id}) do
    %{content_id: content_id, reaction_count: %{fire: Enum.count(reactions)}}
  end
end
