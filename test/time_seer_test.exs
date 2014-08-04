defmodule TimeSeerTest do
  use ExUnit.Case

  test "mm-dd-yyyy date parsing" do
    assert TimeSeer.date("01-08-2014", :mmddyyyy) == { 2014, 1, 8 }
    assert TimeSeer.date("01/08 - 2014", :mmddyyyy) == { 2014, 1, 8 }
  end

  test "dd-mm-yyyy date parsing" do
    assert TimeSeer.date("20-01-2014", :ddmmyyyy) == { 2014, 1, 20 }
  end

  test "yyyy-mm-dd date parsing" do
    assert TimeSeer.date("2014-12-24", :yyyymmdd) == { 2014, 12, 24 }
  end

  test "yyyy-mm-dd date parsing should work as default without format parameter" do
    assert TimeSeer.date("2014-12-24") == { 2014, 12, 24 }
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

  test "date parsing of invalid date should return nil" do
    assert TimeSeer.date("2014-12-99", :yyyymmdd) == nil
  end
end
