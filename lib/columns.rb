
# columns are 0-based. The starting coordinate of column 0 is 0.
class Columns
  attr_reader :width

  def initialize(params = {})
    @width = params.fetch(:width)
  end

  # returns a column number
  def snap_right(x)
    (x.to_f / @width).ceil
  end

  def start(column)
    column * @width
  end
end
