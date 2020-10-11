defmodule AwesomeBot.Slack do
  @incoming_webhook_url Application.get_env(:awesome_bot, :slack_incoming_webhook_url)
  @channel Application.get_env(:awesome_bot, :slack_channel)
  @headers [{"Content-type", "application/json"}]

  def run(list) do
    Enum.each(list, &do_post/1)
  end

  defp do_post(%{
         text: text,
         created_at: created_at,
         profile_image_url_https: profile_image_url_https,
         url: url,
         screen_name: screen_name
       }) do
    body =
      %{
        text: "#{text}\n#{url}\n(#{created_at})",
        username: screen_name,
        icon_url: profile_image_url_https,
        link_names: 1,
        channel: @channel
      }
      |> Jason.encode!()

    HTTPoison.post!(@incoming_webhook_url, body, @headers)
  end
end
