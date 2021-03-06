# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
use Mix.Config

# Configures the endpoint
config :quiz, QuizWeb.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "oSTm4+blwS0Yz3cqlYvMKiW4pzOKbppIG5EIefzSzL6xcLo5gfYECkjHsvXhWF8O",
  render_errors: [view: QuizWeb.ErrorView, accepts: ~w(html json)],
  pubsub: [name: Quiz.PubSub, adapter: Phoenix.PubSub.PG2],
  live_view: [
    signing_salt: "Oem/n5mShACJMBSKLyrz5vljXlOQP6rF"
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env()}.exs"
