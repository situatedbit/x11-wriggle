
# columns are 1-based. The start coordinate of the left-most column is 0; it is column 1.
class Columns
  def initialize(params = {})
    @width = params.fetch(:width)
  end

  # returns a column number
  def snap_right(x)
    (x.to_f / @width).ceil
  end

  def start(column)
    column > 0 ? ((column - 1) * @width) : (column * @width)
  end
end
