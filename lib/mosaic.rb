class Mosaic
  attr_reader :rows, :cols, :grid, :tiles

  DuplicateTile = Class.new(RuntimeError)

  def initialize(rows, cols)
    @rows, @cols = rows, cols
    @grid = Array.new(@rows) { Array.new(@cols) {:empty} }
    @tiles = []
  end

  def area
    @rows * @cols
  end

  def available_area
    count = 0
    (0...@rows).each do |row|
      (0...@cols).each do |col|
        count += 1 if available?(row, col)
      end
    end
    count
  end

  def available?(row, col)
    @grid[row] && @grid[row][col] == :empty
  end

  def covered_area
    area - available_area
  end

  DRAW_CHARS = %[!@#\$%^&*_=+\/\:;'.~abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ].split('')
  def draw
    charmap = Hash[@tiles.zip(DRAW_CHARS.first(@tiles.size))]
    charmap[:empty] = ' '
    horizontal = '-'*(@cols + 2)
    puts horizontal
    puts(@grid.map do |row|
      "|#{row.map{|tile| charmap[tile]}.join}|"
    end.join("\n"))
    puts horizontal
  end

  def can_place?(tile, row, col)
    (row...(row + tile.rows)).each do |r|
      (col...(col + tile.cols)).each do |c|
        return false unless available?(r, c)
      end
    end
    true
  end

  def generate!
    candidates = Tile.rand_covering(area)
    until candidates.empty? || candidates.all?{|tile| tile.is_a?(Tile::Small) }
      tile = candidates.shift
      placed = false
      5.times {
        row, col = random_location(tile)
        placed = place!(tile, row, col)
        break if placed
      }
      candidates.concat tile.shatter unless placed
    end
    # Fill in missed spaces
    (0...@rows).each do |row|
      (0...@cols).each do |col|
        place!(Tile::Small.new, row, col) if available?(row, col)
      end
    end
    true
  end

  def has_tile?(tile)
    !!@tiles.find {|t| t.equal? tile}
  end

  def place!(tile, row, col)
    raise DuplicateTile if has_tile?(tile)
    return false unless can_place?(tile, row, col)
    @tiles << tile
    (row...(row + tile.rows)).each do |r|
      (col...(col + tile.cols)).each do |c|
        @grid[r][c] = tile
      end
    end
    true
  end

  def random_location(tile)
    [rand(rows - tile.rows + 1), rand(cols - tile.cols + 1)]
  end

  def space_available?
    covered_area < area
  end
end
