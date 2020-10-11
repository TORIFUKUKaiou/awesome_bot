# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
import Config

config :awesome_bot,
  target: Mix.target(),
  twitter_query: System.get_env("AWESOME_BOT_TWITTER_QUERY"),
  twitter_search_interval:
    System.get_env("AWESOME_BOT_TWITTER_SEARCH_INTERVAL") |> String.to_integer(),
  slack_incoming_webhook_url: System.get_env("AWESOME_BOT_SLACK_INCOMING_WEBHOOK_URL"),
  slack_channel: System.get_env("AWESOME_BOT_SLACK_CHANNEL"),
  docomo_text_to_speech_api_key: System.get_env("AWESOME_BOT_DOCOMO_TEXT_TO_SPEECH_API_KEY")

config :extwitter, :oauth,
  consumer_key: System.get_env("AWESOME_BOT_TWITTER_CONSUMER_KEY"),
  consumer_secret: System.get_env("AWESOME_BOT_TWITTER_CONSUMER_SECRET"),
  access_token: System.get_env("AWESOME_BOT_TWITTER_ACCESS_TOKEN"),
  access_token_secret: System.get_env("AWESOME_BOT_TWITTER_ACCESS_TOKEN_SECRET")

config :tzdata, :data_dir, "/root/tzdata"

config :awesome_bot, AwesomeBot.Scheduler,
  jobs: [
    {"0 22 * * *", {AwesomeBot.Alarm, :run, ["おはようございます。朝ですよ。", 3]}}
  ]

# Customize non-Elixir parts of the firmware. See
# https://hexdocs.pm/nerves/advanced-configuration.html for details.

config :nerves, :firmware, rootfs_overlay: "rootfs_overlay"

# Set the SOURCE_DATE_EPOCH date for reproducible builds.
# See https://reproducible-builds.org/docs/source-date-epoch/ for more information

config :nerves, source_date_epoch: "1602320186"

# Use Ringlogger as the logger backend and remove :console.
# See https://hexdocs.pm/ring_logger/readme.html for more information on
# configuring ring_logger.

config :logger, backends: [RingLogger]

if Mix.target() != :host do
  import_config "target.exs"
end
