#  stretch
# ```
# stretch --left
# stretch --right (default)
# ```
#
# The increments would probably have to be divisions of display size (maybe, 10%?), so I could easily apply the opposite operation to an adjacent window to complete the tiling
#
# `([ ][ ]) -> ([][  ])`

require 'optparse'

require_relative 'lib/column_layout'
require_relative 'lib/display'
require_relative 'lib/stretch'
require_relative 'lib/windows'
require_relative 'lib/wmctrl_command'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: window-stretch [-d DIRECTION]"

  options[:direction] = 'right'
  opts.on('-d', '--direction DIRECTION', 'left or right (default: right)') do |direction|
    options[:direction] = direction
  end

  opts.on('-h', '--help', 'Displays help') do
		puts opts
		exit
	end
end.parse!

direction = options[:direction]
columns = 10

stretch = Stretch.new(
  window: Window.active,
  to_right: direction == 'right',
  layout: ColumnLayout.new(count: columns, width: Display.root.width)
)

command = WmctrlCommand.new(left: stretch.left, right: stretch.right, width: stretch.width, height: stretch.height)

puts command
