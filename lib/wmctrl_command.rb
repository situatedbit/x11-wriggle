# wmctrl -r :ACTIVE: -e 0,-1,-1,800,-1

class WmctrlCommand
  attr_reader :x, :y, :width, :height

  def initialize(params = {})
    @x = params.fetch :x, -1
    @y = params.fetch :y, -1
    @width = params.fetch :width, -1
    @height = params.fetch :height, -1
  end

  def to_s
    "wmctrl -r :ACTIVE: -e 0,#{x},#{y},#{width},#{height}"
  end
end
