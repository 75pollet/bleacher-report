defmodule BleacherReport.Repo do
  use Ecto.Repo,
    otp_app: :bleacher_report,
    adapter: Ecto.Adapters.Postgres
end
