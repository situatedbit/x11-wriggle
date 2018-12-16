require_relative 'wmctrl_command'

class Stretch
  def initialize(params = {})
    @window = params.fetch(:window)
    @to_right = params.fetch(:to_right, true)
    @layout = params.fetch(:layout)
  end

  def left
    @to_right ? @window.left : @layout.column(@window.left - 1).left
  end

  def right
    @to_right ? @layout.column(@window.right + 1).right : @window.right
  end

  def width
    right - left
  end

  def command
    WmctrlCommand.new(x: left, width: width)
  end
end
