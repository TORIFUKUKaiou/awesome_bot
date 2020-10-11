defmodule AwesomeBot.Worker do
  use GenServer

  @interval Application.get_env(:awesome_bot, :twitter_search_interval)
  @disk_storage if(AwesomeBot.Application.target() == :host,
                  do: :disk_storage,
                  else: :"/root/disk_storage"
                )

  def start_link(state \\ %{}) do
    GenServer.start_link(__MODULE__, state, name: __MODULE__)
  end

  def init(_state) do
    Process.send_after(__MODULE__, :event, 60 * 1000)
    table = table()
    {:ok, %{last_created_at: last_created_at(table), table: table}}
  end

  def handle_info(:event, %{last_created_at: last_created_at, table: table}) do
    Process.send_after(__MODULE__, :event, @interval)

    new_last_created_at = run(last_created_at)
    :dets.insert(table, last_created_at: new_last_created_at)

    {:noreply, %{last_created_at: new_last_created_at, table: table}}
  end

  defp run(last_created_at) do
    list = AwesomeBot.SearchTwitter.run(last_created_at)
    AwesomeBot.Slack.run(list)

    case Enum.count(list) do
      0 -> last_created_at
      _ -> Enum.at(list, -1) |> Map.get(:created_at)
    end
  end

  defp last_created_at(table) do
    case :dets.lookup(table, :last_created_at) |> Enum.at(0) do
      nil -> Timex.now() |> Timex.beginning_of_month() |> Timex.to_unix()
      {:last_created_at, last_created_at} -> last_created_at
    end
  end

  defp table do
    {:ok, table} = :dets.open_file(@disk_storage, type: :set)
    table
  end
end
