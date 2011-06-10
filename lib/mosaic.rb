class Mosaic
  attr_reader   :rows, :cols
  attr_accessor :width, :height

  def initialize(rows, cols, width=cols, height=rows)
    @rows, @cols, @width, @height = rows, cols, width, height
    validate
  end

  private

  def validate
    unless @height % @rows == 0
      raise ArgumentError.new("Height should be a multiple of rows")
    end
    unless @width % @cols == 0
      raise ArgumentError.new("Width should be a multiple of cols")
    end
  end
end
