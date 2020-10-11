defmodule AwesomeBot.SearchTwitter do
  @query Application.get_env(:awesome_bot, :twitter_query)

  def run(last_created_at) do
    do_search(last_created_at)
  end

  defp do_search(last_created_at) do
    response = ExTwitter.search(@query, count: 100, search_metadata: true)

    response.statuses
    |> statuses(last_created_at)
    |> do_search_next_page(response.metadata, last_created_at, [])
    |> Enum.sort_by(& &1.created_at)
  end

  defp do_search_next_page([], _metadata, _last_created_at, result_list), do: result_list

  defp do_search_next_page(prev_page_list, metadata, last_created_at, result_list) do
    response = ExTwitter.search_next_page(metadata)

    response.statuses
    |> statuses(last_created_at)
    |> do_search_next_page(response.metadata, last_created_at, result_list ++ prev_page_list)
  end

  defp statuses(statuses, last_created_at) do
    statuses
    |> Enum.map(&do_convert/1)
    |> Enum.filter(fn %{created_at: created_at} -> created_at > last_created_at end)
  end

  defp do_convert(%{
         id_str: id_str,
         text: text,
         created_at: created_at,
         user: %{
           profile_image_url_https: profile_image_url_https,
           screen_name: screen_name
         }
       }) do
    %{
      text: text,
      created_at:
        Timex.parse!(created_at, "{WDshort} {Mshort} {D} {h24}:{m}:{s} +0000 {YYYY}")
        |> Timex.to_unix(),
      profile_image_url_https: profile_image_url_https,
      screen_name: screen_name,
      url: "https://twitter.com/#{screen_name}/status/#{id_str}"
    }
  end
end
