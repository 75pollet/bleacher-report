defmodule BleacherReport.Reports do
  @moduledoc """
    This is where the logics of inserting, updating and
    deleting is done
  """
  alias BleacherReport.Reports.Report
  alias BleacherReport.Repo
  import Ecto.Query

  @cache :bleacher_cache

  @doc """
  inserts a report into the database
  """
  def insert_report(params) do
    %Report{}
    |> Report.changeset(params)
    |> Repo.insert()
  end

  @doc """
  checks if the user id exists. if it does not, the report is inserted.
  if it does, then the report is updated instead
  """
  def check_user_and_insert_report(params) do
    case Repo.get(Report, params["user_id"]) do
      nil -> insert_report(params)
      _report -> :exists
    end
  end

  @doc """
  insert a reaction into the database then updates the ets cache if the insert
  is successful
  """
  def insert_and_save_to_cache(params) do
    case check_user_and_insert_report(params) do
      {:ok, _report} ->
        ConCache.put(@cache, params["content_id"], _reports_by_content_id(params["content_id"]))

      :exists ->
        :exists

      _ ->
        nil
    end
  end

  defp _get_reports(content_id) do
    query = from r in Report, where: r.content_id == ^content_id
    Repo.all(query)
  end

  defp _reports_by_content_id(content_id) do
    content_id
    |> _get_reports()
    |> Enum.map(fn report ->
      _build_cache_params(report)
    end)
  end

  defp _build_cache_params(report) do
    %{
      "user_id" => report.user_id,
      "action" => report.action,
      "content_id" => report.content_id,
      "reaction_type" => report.reaction_type,
      "type" => report.type
    }
  end
end
