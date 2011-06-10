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

  describe "comparison" do
    it "is == to another tile of the same dimensions" do
      Tile.new(1,2).should == Tile.new(1,2)
    end

    it "is not == to a tile with a different width" do
      Tile.new(1,1).should_not == Tile.new(2,1)
    end

    it "is not == to a tile with a different height" do
      Tile.new(1,1).should_not == Tile.new(1,2)
    end

    it "is #equal to itself" do
      tile = Tile.new(1,1)
      tile.should be_equal(tile)
    end

    it "is not #equal to another tile of the same dimensions" do
      Tile.new(1,1).should_not be_equal(Tile.new(1,1))
    end
  end

  it "knows its area" do
    Tile.new(1,1).area.should == 1
    Tile.new(2,2).area.should == 4
    Tile.new(2,3).area.should == 6
  end

  it "knows the area of many tiles" do
    tiles = 1.upto(3).map{|i| Tile.new(i, i) }
    Tile.area(tiles).should == 14
  end

  describe "picking a random tile" do
    it "returns some tile when there is no area limit" do
      Tile.rand.should be_a(Tile)
    end

    it "returns a tile of a maximum area" do
      Tile.rand(3).should be_a(Tile::Small)
    end
  end
end
