defmodule AwesomeBot.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  def start(_type, _args) do
    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: AwesomeBot.Supervisor]

    children =
      [
        # Children for all targets
        # Starts a worker by calling: AwesomeBot.Worker.start_link(arg)
        # {AwesomeBot.Worker, arg},
        # This is the new line
        AwesomeBot.Scheduler
      ] ++ children(target())

    Supervisor.start_link(children, opts)
  end

  # List all child processes to be supervised
  def children(:host) do
    [
      # Children that only run on the host
      # Starts a worker by calling: AwesomeBot.Worker.start_link(arg)
      # {AwesomeBot.Worker, arg},
    ]
  end

  def children(_target) do
    [
      # Children for all targets except host
      # Starts a worker by calling: AwesomeBot.Worker.start_link(arg)
      # {AwesomeBot.Worker, arg},
    ]
  end

  def target() do
    Application.get_env(:awesome_bot, :target)
  end
end
