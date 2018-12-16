require_relative 'wmctrl_command'

class Stretch
  Action = Struct.new(
      :column_offset_left,
      :column_offset_right,
      :snap_offset_left,
      :snap_offset_right
  )

  def self.compress
    # Snap to current column, then bump column number to move sides inward
    Action.new(1, -1, 0, 0)
  end

  def self.expand
    # Rely only on snap offsets to move sides outward
    Action.new(0, 0, -1, 1)
  end

  class Right
    def self.left(window_left, layout, action)
      window_left
    end

    def self.right(window_right, layout, action)
      # Apply snap offset, then offset the column number
      column = layout.column_index(window_right + action.snap_offset_right)

      layout.columns[column + action.column_offset_right].right
    end
  end

  class Left
    def self.left(window_left, layout, action)
      # Apply snap offset, then offset the column number
      column = layout.column_index(window_left + action.snap_offset_left)

      layout.columns[column + action.column_offset_left].left
    end

    def self.right(window_right, layout, action)
        window_right
    end
  end

  def initialize(params = {})
    @action = params.fetch(:action, self.class.expand)
    @window = params.fetch(:window)
    @side = params.fetch(:side)
    @layout = params.fetch(:layout)
  end

  def left
    @side.left @window.left, @layout, @action
  end

  def right
    @side.right @window.right, @layout, @action
  end

  def width
    right - left
  end

  def command
    WmctrlCommand.new(x: left, width: width)
  end
end
