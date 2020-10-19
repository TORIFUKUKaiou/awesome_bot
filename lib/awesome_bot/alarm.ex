defmodule AwesomeBot.Alarm do
  @file_path if AwesomeBot.Application.target() == :host,
               # host
               do: "alarm.wav",
               # target
               else: "/tmp/alarm.wav"
  @play_cmd if(AwesomeBot.Application.target() == :host,
              # host
              do:
                if(:os.type() == {:unix, :darwin},
                  do: "afplay #{@file_path}",
                  else: "aplay -q #{@file_path}"
                ),
              # target
              else: "aplay -q #{@file_path}"
            )
            |> String.to_charlist()

  def run(text \\ "ナーブスはエリクサーのアイオーティーでナウでヤングなクールなすごいやつです", cnt \\ 1) do
    {:ok, content} = AwesomeBot.DocomoTextToSpeech.run(text)

    File.write(@file_path, content)
    1..cnt |> Enum.each(fn _ -> :os.cmd(@play_cmd) end)
  end
end
