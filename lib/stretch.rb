class Stretch
  def initialize(params = {})
    @window = params.fetch(:window)
    @to_right = params.fetch(:to_right, true)
    @columns = params.fetch(:columns)
  end

  def left
    @to_right ? -1 : @columns.start(@columns.snap_right(@window.left) - 1)
  end

  def right
  end

  def width
  end

  def height
  end

  private
  def column(x)
      (x * @columns) / @screen.width
  end
end
