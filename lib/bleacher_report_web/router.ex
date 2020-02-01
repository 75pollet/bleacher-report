defmodule BleacherReportWeb.Router do
  use BleacherReportWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BleacherReportWeb do
    pipe_through :api

    post "/reaction", BleacherReportController, :new
  end
end
