require 'optparse'

require_relative 'lib/column_layout'
require_relative 'lib/display'
require_relative 'lib/stretch'
require_relative 'lib/windows'
require_relative 'lib/wmctrl_command'

class WindowStretchError < StandardError
end

begin
  options = {}
  OptionParser.new do |opts|
    opts.banner = "Usage: window-stretch expand|compress OPTIONS"

    opts.on('-s', '--side SIDE', 'left or right (default: right)') do |side|
      options[:side] = side
    end

    opts.on('-d', '--dry-run', 'do not move window') do |dry_run|
      options[:dry_run] = true
    end

    opts.on('-v', '--verbose', 'verbose output') do |debug|
      options[:verbose] = true
    end

    opts.on('-h', '--help', 'displays help') do
  		puts opts
  		exit
  	end
  end.parse!

  action = ARGV[0]
  raise WindowStretchError, 'Action required: compress or expand' unless ['compress', 'expand'].include?(action)

  columns = 10
  side = options.fetch :side, 'right'
  be_verbose = options.fetch :verbose, false
  is_dry_run = options.fetch :dry_run, false

  display = Display.root
  layout = ColumnLayout.new(count: columns, width: display.width)
  window = Window.active

  stretch = Stretch.new(
    window: window,
    side: side == 'right' ? Stretch::Right : Stretch::Left,
    layout: layout,
    action: action == 'expand' ? Stretch.expand : Stretch.compress
  )

  if be_verbose
    puts window
    puts display
    puts layout
    puts stretch.command
  end

  `#{stretch.command}` unless is_dry_run
rescue OptionParser::InvalidOption => e
  puts e.message
rescue WindowStretchError => e
  puts e.message
end
