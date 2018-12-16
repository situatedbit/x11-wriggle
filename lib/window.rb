require_relative 'parser'

class Window
  def self.active
    window = Parser.parse_window(`xwininfo -id $(xdotool getactivewindow)`)

    borders = Parser.parse_borders(`xprop _NET_FRAME_EXTENTS -id $(xdotool getactivewindow)`)

    Window.new(
      x: window[:x] - borders[:left],
      y: window[:y] - borders[:top],
      width: borders[:left] + window[:width] + borders[:right],
      height: borders[:top] + window[:height] + borders[:bottom]
    )
  end

  def initialize(params = {})
    @x = params.fetch(:x)
    @y = params.fetch(:y)
    @width = params.fetch(:width)
    @height = params.fetch(:height)
  end

  def left
    @x
  end

  def right
    @x + @width
  end

  def to_s
    "window left: #{left}, right: #{right}, width: #{@width}, height: #{@height}"
  end
end
