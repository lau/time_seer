defmodule TimeSeerDateTest do
  use ExUnit.Case, async: true

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

  test "date parsing of invalid date should return nil" do
    assert TimeSeer.date("2014-12-99", :yyyymmdd) == nil
  end
end
