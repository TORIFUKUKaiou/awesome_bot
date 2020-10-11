# AwesomeBot

**TODO: Add description**

## Targets

Nerves applications produce images for hardware targets based on the
`MIX_TARGET` environment variable. If `MIX_TARGET` is unset, `mix` builds an
image that runs on the host (e.g., your laptop). This is useful for executing
logic tests, running utilities, and debugging. Other targets are represented by
a short name like `rpi3` that maps to a Nerves system image for that platform.
All of this logic is in the generated `mix.exs` and may be customized. For more
information about targets see:

https://hexdocs.pm/nerves/targets.html#content

## Getting Started

To start your Nerves app:
  * `export MIX_TARGET=my_target` or prefix every command with
    `MIX_TARGET=my_target`. For example, `MIX_TARGET=rpi3`
  * Install dependencies with `mix deps.get`
  * Create firmware with `mix firmware`
  * Burn to an SD card with `mix firmware.burn`

## Learn more

  * Official docs: https://hexdocs.pm/nerves/getting-started.html
  * Official website: https://nerves-project.org/
  * Forum: https://elixirforum.com/c/nerves-forum
  * Discussion Slack elixir-lang #nerves ([Invite](https://elixir-slackin.herokuapp.com/))
  * Source: https://github.com/nerves-project/nerves

** environment variables

```
export AWESOME_BOT_DOCOMO_TEXT_TO_SPEECH_API_KEY="secret"
export AWESOME_BOT_TWITTER_QUERY="NervesJP OR @NervesConf OR @NervesProject OR (Elixir AND Nerves) OR (Elixir AND IoT) -RT"
export AWESOME_BOT_TWITTER_SEARCH_INTERVAL="300000"
export AWESOME_BOT_SLACK_INCOMING_WEBHOOK_URL="https://hooks.slack.com/services/..."
export AWESOME_BOT_SLACK_CHANNEL="notification-awesome"
export AWESOME_BOT_TWITTER_CONSUMER_KEY="secret"
export AWESOME_BOT_TWITTER_CONSUMER_SECRET="secret"
export AWESOME_BOT_TWITTER_ACCESS_TOKEN="secret"
export AWESOME_BOT_TWITTER_ACCESS_TOKEN_SECRET="secret"
export AWESOME_BOT_NETWORK_SSID="ssid"
export AWESOME_BOT_NETWORK_PSK="psk"
```
