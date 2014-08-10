defmodule TimeSeer.Date do
  # default format to yyyymmdd
  def date(string) do date(string, :yyyymmdd) end

  def date(string, format) do
    map_date(string)
    |> handle_captured_regex(format)
  end

  defp map_date(string) do
    Regex.named_captures(~r/(?<first>[0-9]+)[^0-9]+(?<second>[0-9]+)[^0-9]+(?<third>[^\"]+)/, string)
  end

  defp handle_captured_regex(nil, _) do nil end
  defp handle_captured_regex(map, format) do
    map = map |> convert_to_integers
    case format do
      :yyyymmdd -> { map[:first], map[:second], map[:third] }
      :mmddyyyy -> { map[:third], map[:first], map[:second] }
      :ddmmyyyy -> { map[:third], map[:second], map[:first] }
    end
    |> validate_date
  end

  # convert to integers and make keys atoms
  defp convert_to_integers(map) do
    %{:first => to_int(map["first"]),
      :second => to_int(map["second"]),
      :third => to_int(map["third"])
     }
  end

  defp to_int(string) do elem(Integer.parse(string),0) end

  def validate_date(date) do
    if (:calendar.valid_date(date)) do date else nil end
  end
end
