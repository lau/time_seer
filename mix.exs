defmodule TimeSeer.Mixfile do
  use Mix.Project

  def project do
    [app: :time_seer,
     version: "0.0.2",
     elixir: "~> 0.15.0",
     package: package,
     description: description,
     deps: deps]
  end

  def application do
    [applications: []]
  end

  defp deps do
    []
  end

  defp package do
    %{ licenses: ["MIT"],
       contributors: ["Lau Taarnskov"],
       links: %{ "GitHub" => "https://github.com/lau/time_seer" } }
  end

  defp description do
    """
    TimeSeer is an Elixir library for parsing dates and times and returning
    Erlang style date and time tuples.
    Eg. "15:12:07" "2:42pm" "24/12/2014" will become {15,12,7}, {14,42,0}, and
    {2014,12,24} respectively.
    """
  end
end
