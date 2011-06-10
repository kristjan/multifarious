class Tile
  attr_reader :rows, :cols

  class Large < Tile
    def initialize
      @rows = @cols = 3
    end
  end

  class Medium < Tile
    def initialize
      @rows = @cols = 2
    end
  end

  class Small < Tile
    def initialize
      @rows = @cols = 1
    end

    def shatter
      []
    end
  end

  def self.rand(max_area=nil)
    tiles = [Large, Medium, Small].map(&:new).select do |tile|
      max_area.nil? || tile.area <= max_area
    end
    tiles[Kernel.rand(tiles.size)]
  end

  def self.rand_covering(area)
    tiles = []
    while self.area(tiles) < area
      tiles << Tile.rand(area - self.area(tiles))
    end
    tiles
  end

  def self.area(tiles)
    tiles.inject(0) {|sum, tile| sum + tile.area}
  end

  def initialize(rows, cols)
    @rows, @cols = rows, cols
  end

  def ==(other)
    return false unless other.is_a?(Tile)
    self.rows == other.rows && self.cols == other.cols
  end

  def area
    @rows * @cols
  end

  def shatter
    Tile.rand_covering(area)
  end
end
