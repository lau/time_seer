defmodule TimeSeer.Time do
  def time(string) do
    map = Regex.named_captures(~r/(?<hours>[0-9]{1,2})[\:\.](?<minutes>[0-9]{1,2})[\:\.]?(?<seconds>[0-9]{1,2})?/, string)
    process_time_regexed(string, map)
  end

  defp process_time_regexed(_, nil) do nil end

  defp process_time_regexed(string, map) do
    { map["hours"] , map["minutes"], map["seconds"] }
    |> convert_to_integers
    |> convert_from_12_hour_format(string)
    |> validate_time
  end

  # if no seconds were found, set seconds to 0
  def convert_to_integers({hours, minutes, ""}) do
    convert_to_integers({hours, minutes, "0"})
  end

  def convert_to_integers({hours, minutes, seconds}) do
    {to_int(hours), to_int(minutes), to_int(seconds)}
  end

  defp to_int(string) do elem(Integer.parse(string),0) end

  defp convert_from_12_hour_format({hours, minutes, seconds}, string) do
    ampm = normalize_ampm(Regex.run(~r/[ap]m/i, string))
    {ampm_to_24_hour(hours, ampm), minutes, seconds}
  end

  defp normalize_ampm(ampm) when is_list(ampm) do
    String.downcase(hd(ampm))
  end
  defp normalize_ampm(ampm) do ampm end

  # If am: for the first hour at and after midnight subtract 12 hours so we get 0
  def ampm_to_24_hour(hour, "am") when hour == 12 do hour - 12 end
  def ampm_to_24_hour(hour, "pm") when hour < 12 do hour + 12 end
  # default case: do not change the hour
  def ampm_to_24_hour(hour, _) do hour end

  def validate_time(time) do
    cond do
      elem(time, 0) > 23 -> nil # hours more than 23
      elem(time, 1) > 59 -> nil # minutes more than 59
      elem(time, 2) > 59 -> nil # seconds more than 59
      true -> time # the elements were not too large, pass through
    end
  end
end
