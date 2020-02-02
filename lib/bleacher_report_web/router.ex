defmodule BleacherReportWeb.Router do
  use BleacherReportWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/", BleacherReportWeb do
    pipe_through :api

    post "/reaction", BleacherReportController, :reaction
    get "/reaction_counts/:content_id", BleacherReportController, :count
  end
end
