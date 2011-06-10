require "spec_helper"

describe Mosaic do
  describe "initializing" do
    it "stores the rows" do
      Mosaic.new(1,2,4,6).rows.should == 1
    end

    it "stores the columns" do
      Mosaic.new(1,2,4,6).cols.should == 2
    end

    it "stores the width" do
      Mosaic.new(1,2,4,6).width.should == 4
    end

    it "stores the height" do
      Mosaic.new(1,2,4,6).height.should == 6
    end

    it "defaults the width to the number of columns" do
      Mosaic.new(1,2).width.should == 2
    end

    it "defaults the height to the number of rows" do
      Mosaic.new(1,2).height.should == 1
    end

    it "disallows widths that aren't multiples of the columns" do
      expect{ Mosaic.new(2, 2, 3, 2) }.to raise_error(ArgumentError)
    end

    it "disallows heights that aren't multiples of the rows" do
      expect{ Mosaic.new(2, 2, 2, 3) }.to raise_error(ArgumentError)
    end
  end
end
