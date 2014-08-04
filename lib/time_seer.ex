defmodule TimeSeer do
  def date(string, :mmddyyyy) do
    map = map_date(string)
    { to_int(map["third"]), to_int(map["first"]), to_int(map["second"]) } |> validate_date
  end

  def date(string, :ddmmyyyy) do
    map = map_date(string)
    { to_int(map["third"]), to_int(map["second"]), to_int(map["first"]) } |> validate_date
  end

  def date(string, :yyyymmdd) do
    map = map_date(string)
    { to_int(map["first"]), to_int(map["second"]), to_int(map["third"]) } |> validate_date
  end

  def date(string) do date(string, :yyyymmdd) end

  def time(string) do
    map = Regex.named_captures(~r/(?<first>[0-9]{1,2})[\:\.](?<second>[0-9]{1,2})[\:\.]?(?<third>[0-9]{1,2})?/, string)
    hour = to_int(map["first"])
    ampm = Regex.run(~r/[ap]m/i, string)
    if ampm do hour = ampm_to_24_hour(hour, String.downcase(hd(ampm))) end
    seconds = 0
    if (map["third"]!="") do seconds = to_int(map["third"]) end
    { hour , to_int(map["second"]), seconds } |> validate_time
  end

  # If am: for the first hour at and after midnight subtract 12 hours so we get 0
  def ampm_to_24_hour(hour, "am") when hour == 12 do hour - 12 end
  def ampm_to_24_hour(hour, "pm") when hour < 12 do hour + 12 end
  # default case: do not change the hour
  def ampm_to_24_hour(hour, _) do hour end

  def map_date(string) do
    Regex.named_captures(~r/(?<first>[0-9]+)[^0-9]+(?<second>[0-9]+)[^0-9]+(?<third>[^\"]+)/, string)
  end

  def to_int(string) do
    elem(Integer.parse(string),0)
  end

  def validate_date(date) do
    if (:calendar.valid_date(date)) do date else nil end
  end

  def validate_time(time) do
    cond do
      elem(time, 0) > 23 ->
        nil
      elem(time, 1) > 59 ->
        nil
      elem(time, 2) > 59 ->
        nil
      true ->
        time
    end
  end
end
