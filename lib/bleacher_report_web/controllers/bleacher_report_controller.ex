defmodule BleacherReportWeb.BleacherReportController do
  use BleacherReportWeb, :controller
  alias BleacherReport.Reports

  def reaction(conn, %{"action" => "add"} = params) do
    case Reports.insert_and_save_to_cache(params) do
      :ok -> send_resp(conn, 200, "ok")
      nil -> send_resp(conn, 422, "please check your data")
      :exists -> send_resp(conn, 422, "reaction for this user exists")
    end
  end

  def reaction(conn, %{"action" => "remove"} = params) do
    case Reports.delete_and_update_cache(params) do
      :ok -> send_resp(conn, 200, "ok")
      _ -> send_resp(conn, 422, "reaction doesn't exist")
    end
  end
end
