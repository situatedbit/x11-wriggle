require 'parser'

class Window
  include Parser

  def self.active()
      active_window = parse_xdotool_active_window(`xdotool getactivewindow`)

      window_geometry = parse_xdotool_geometry(`xdotool getwindowgeometry --shell #{active_window}`)

      borders = parse_xprop_frame_extensions(`xprop _NET_FRAME_EXTENTS -id #{active_window}`)

      Window.new(
        x: window_geometry.x,
        y: window_geometry.
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
end
