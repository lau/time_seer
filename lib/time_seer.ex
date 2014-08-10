defmodule TimeSeer do
  def time(string) do TimeSeer.Time.time(string) end
  def date(string) do TimeSeer.Date.date(string) end
  def date(string, opts) do TimeSeer.Date.date(string, opts) end
end
