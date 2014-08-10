defmodule TimeSeerTimeTest do
  use ExUnit.Case, async: true

  test "time parsing of invalid input" do
    assert TimeSeer.time("") == nil
  end

  test "time parsing" do
    assert TimeSeer.time("10:12am") == { 10, 12, 0 }
    assert TimeSeer.time("12:00am") == { 0, 0, 0 }
    assert TimeSeer.time("12:00pm") == { 12, 0, 0 }
    assert TimeSeer.time("10:12") == { 10, 12, 0 }
    assert TimeSeer.time("10:12pm") == { 22, 12, 0 }
    assert TimeSeer.time("10.12pm") == { 22, 12, 0 }
    assert TimeSeer.time("10:12:33am") == { 10, 12, 33 }
    assert TimeSeer.time("10.12.33 pm") == { 22, 12, 33 }
    assert TimeSeer.time("12.12.33 pm") == { 12, 12, 33 }
    assert TimeSeer.time("12.12.33 am") == { 0, 12, 33 }
    assert TimeSeer.time("10:12:33 PM") == { 22, 12, 33 }
  end

  test "time parsing of invalid time should return nil" do
    assert TimeSeer.time("25:00") == nil
    assert TimeSeer.time("24:00") == nil
    assert TimeSeer.time("0:60") == nil
    assert TimeSeer.time("0:60:60") == nil
    assert TimeSeer.time("10:10:99") == nil
  end
end
