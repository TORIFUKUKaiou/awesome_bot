defmodule AwesomeBot.DocomoTextToSpeech do
  @api_key Application.get_env(:awesome_bot, :docomo_text_to_speech_api_key)
  @url "https://api.apigw.smt.docomo.ne.jp/futureVoiceCrayon/v1/textToSpeech?APIKEY=#{@api_key}"
  @headers [{"Content-Type", "application/json"}]
  @default_opts [
    command: "AP_Synth",
    speaker_id: 1,
    style_id: 1,
    speech_rate: 1.0,
    power_rate: 1.0,
    voice_type: 1.0,
    audio_file_format: 2
  ]

  def run(text, opts \\ []) do
    params =
      @default_opts
      |> Keyword.merge(opts)
      |> Keyword.put_new(:text_data, text)
      |> Enum.into(%{}, fn {k, v} -> {k |> to_string() |> camelize(), v} end)
      |> Jason.encode!()

    HTTPoison.post(@url, params, @headers)
    |> handle_response()
  end

  defp handle_response({:ok, %HTTPoison.Response{status_code: 200, body: body}}), do: {:ok, body}

  defp handle_response(_), do: :error

  defp camelize(key) when key == "speaker_id", do: "SpeakerID"

  defp camelize(key) when key == "style_id", do: "StyleID"

  defp camelize(key), do: Macro.camelize(key)
end
