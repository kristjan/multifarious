class Mosaic
  attr_reader   :rows, :cols

  attr_reader :tiles

  def initialize(rows, cols)
    @rows, @cols = rows, cols
    generate!
  end

  def generate!
    @grid = Array.new(@rows) {Array.new(@cols)}
  end
end
