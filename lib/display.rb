require_relative 'parser'

class Display
  attr_reader :width, :height

  def self.root
    Display.new Parser.parse_display(`xwininfo -shape -root`)
  end

  def initialize(params)
    @width = params.fetch(:width)
    @height = params.fetch(:height)
  end
end
