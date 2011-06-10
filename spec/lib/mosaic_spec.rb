require "spec_helper"

describe Mosaic do
  describe "initializing" do
    it "stores the rows" do
      Mosaic.new(1,2).rows.should == 1
    end

    it "stores the columns" do
      Mosaic.new(1,2).cols.should == 2
    end
  end
end
