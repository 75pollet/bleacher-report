defmodule BleacherReportWeb.Router do
  use BleacherReportWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", BleacherReportWeb do
    pipe_through :api
  end
end
