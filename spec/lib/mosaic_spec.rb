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

  it "knows its area" do
    Mosaic.new(1,1).area.should == 1
    Mosaic.new(2,2).area.should == 4
    Mosaic.new(2,3).area.should == 6
  end

  it "knows its covered area" do
    m = Mosaic.new(4,4)
    m.covered_area.should == 0
    m.place!(Tile::Small.new, 0, 0)
    m.covered_area.should == 1
    m.place!(Tile::Large.new, 1, 1)
    m.covered_area.should == 10
  end

  it "knows its available area" do
    m = Mosaic.new(4,4)
    m.available_area.should == 16
    m.place!(Tile::Small.new, 0, 0)
    m.available_area.should == 15
    m.place!(Tile::Large.new, 1, 1)
    m.available_area.should == 6
  end

  describe "available spaces" do
    before :each do
      @mosaic = Mosaic.new(1,2)
      @mosaic.place!(Tile::Small.new, 0, 1)
    end

    it "knows when a space is available" do
      @mosaic.available?(0,0).should be_true
    end

    it "knows when a space is unavailable" do
      @mosaic.available?(0,1).should be_false
    end

    it "considers out-of-bounds unavailable" do
      @mosaic.available?(3,3).should be_false
    end
  end

  describe "determining whether a tile can be placed" do
    before :each do
      @mosaic = Mosaic.new(4, 4)
      @tile = Tile::Medium.new
      @mosaic.place!(@tile, 2, 2)
    end

    it "returns true when all spaces are clear" do
      @mosaic.can_place?(@tile, 0, 0).should be_true
    end

    it "returns false when there is overlap" do
      @mosaic.can_place?(@tile, 1, 1).should be_false
    end

    it "returns false when the tile is out of bounds" do
      @mosaic.can_place?(@tile, 0, 3).should be_false
    end
  end

  describe "placing a tile" do
    before(:each) do
      @mosaic = Mosaic.new(4, 4)
      @mosaic.place!(Tile::Medium.new, 2, 2)
      @tile = Tile::Medium.new
    end

    it "sets every grid space to the tile" do
      @mosaic.place!(@tile, 0, 0)
      [0, 1].each do |row|
        [0, 1].each do |col|
          @mosaic.grid[row][col].should == @tile
        end
      end
    end

    it "adds the tile to the tile list" do
      @mosaic.place!(@tile, 0, 0)
      @mosaic.tiles.should include(@tile)
    end

    it "returns true when the tile is placed" do
      @mosaic.place!(@tile, 0, 0).should be_true
    end

    it "returns false if placement fails" do
      @mosaic.place!(@tile, 1, 1).should be_false
    end

    it "doesn't let you place the same tile twice" do
      @mosaic.place!(@tile, 0, 0)
      expect {
        @mosaic.place!(@tile, 0, 0)
      }.to raise_error(Mosaic::DuplicateTile)
    end

    it "notifies the tile of its placement" do
      @tile.should_receive(:place!).with(@mosaic, 1, 0)
      @mosaic.place!(@tile, 1, 0)
    end
  end

  it "knows when it contains a tile" do
    mosaic = Mosaic.new(4,4)
    tile = Tile::Medium.new
    other_tile = Tile::Medium.new
    mosaic.should_not have_tile(tile)
    mosaic.place!(tile, 0, 0)
    mosaic.should have_tile(tile)
    mosaic.should_not have_tile(other_tile)
  end

end
