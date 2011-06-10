require "spec_helper"

describe Tile do
  describe "initializing" do
    it "stores the rows" do
      Tile.new(1,2).rows.should == 1
    end

    it "stores the columns" do
      Tile.new(1,2).cols.should == 2
    end
  end
end
