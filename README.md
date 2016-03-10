TimeSeer
========

[![Build
Status](https://travis-ci.org/lau/time_seer.svg?branch=master)](https://travis-ci.org/lau/time_seer)

Parse strings of dates and times and convert them to Erlang style tuples.

The purpose is to parse dates and times providing input that is unambigous, but it does not have to be in a very strict specific format. So for example TimeSeer.time("3:54pm") and TimeSeer.time("15.54.00 ") will both work.

```elixir
{:time_seer, "~> 0.0.6}
```

## Examples

    iex> TimeSeer.date("2014-1-31")
    {2014, 1, 31}
    iex> TimeSeer.date("31/1 2014", :ddmmyyyy)
    {2014, 1, 31}
    iex> TimeSeer.date("1/31/2014", :mmddyyyy)
    {2014, 1, 31}
    iex> TimeSeer.time("23:55")
    {23, 55, 0}
    iex> TimeSeer.time("23:55:15")
    {23, 55, 15}
    iex> TimeSeer.time("2:13pm")
    {14, 13, 0}
    iex> TimeSeer.time("2.13 am")
    {2, 13, 0}
    iex> TimeSeer.time("13.37")
    {13, 37, 0}

