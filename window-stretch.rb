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

puts options[:direction]
columns = 10

def stretch_command(window, direction)
    
end

command = stretch_command(window, direction)

`#{command}`
