module Parser
  class ParserError < StandardError
  end

  def self.parse_window(output)
    # expects output from `xwininfo`
    x = /Absolute upper-left X:\s+(-?\d+)/.match output
    y = /Absolute upper-left Y:\s+(-?\d+)/.match output
    width = /^\s*Width:\s+(\d+)/.match output
    height = /^\s*Height:\s+(\d+)/.match output

    error_message = 'Unable to parse window geometry'
    raise ParserError, error_message unless x && y && width && height

    { x: x[1].to_i, y: y[1].to_i, width: width[1].to_i, height: height[1].to_i }
  end

  def self.parse_borders(output)
    # expects output from `xprop _NET_FRAME_EXTENTS`
    borders = /_NET_FRAME_EXTENTS\(CARDINAL\) = ([\d]+), ([\d]+), ([\d]+), ([\d]+)/.match output

    raise ParserError, 'Unable to parse window borders' unless borders

    { left: borders[1].to_i, right: borders[2].to_i, top: borders[3].to_i, bottom: borders[4].to_i }
  end
end
