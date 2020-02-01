# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :bleacher_report,
  ecto_repos: [BleacherReport.Repo]

# Configures the endpoint
config :bleacher_report, BleacherReportWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "IgAaxC9BVzJSUkXERh9ouFA8e8VUEqnDjCiIx4jFFTWQ/NyeHgFMj7fXw/HnhhRc",
  render_errors: [view: BleacherReportWeb.ErrorView, accepts: ~w(json)],
  pubsub: [name: BleacherReport.PubSub, adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix and Ecto
config :phoenix, :json_library, Jason
config :ecto, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
