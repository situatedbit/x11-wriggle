require 'optparse'

require_relative 'lib/column_layout'
require_relative 'lib/display'
require_relative 'lib/stretch'
require_relative 'lib/windows'
require_relative 'lib/wmctrl_command'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: window-stretch [-d DIRECTION]"

  opts.on('-d', '--direction DIRECTION', 'left or right (default: right)') do |direction|
    options[:direction] = direction
  end

  opts.on('-r', '--dry-run', 'do not move window') do |dry_run|
    options[:dry_run] = true
  end

  opts.on('-v', '--verbose', 'enable verbose') do |debug|
    options[:verbose] = true
  end

  opts.on('-h', '--help', 'Displays help') do
		puts opts
		exit
	end
end.parse!

columns = 10
direction = options.fetch :direction, 'right'
be_verbose = options.fetch :verbose, false
is_dry_run = options.fetch :dry_run, false

display = Display.root
layout = ColumnLayout.new(count: columns, width: display.width)
window = Window.active

stretch = Stretch.new(
  window: window,
  to_right: direction == 'right',
  layout: layout
)

if be_verbose
  puts window
  puts display
  puts layout
  puts stretch.command
end

`#{stretch.command}` unless is_dry_run
