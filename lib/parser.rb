module Parser
  def parse_xdotool_geometry(output)
    # mschaefer@victoria:$ xdotool getwindowgeometry --shell 75501325
    # WINDOW=75501325
    # X=44
    # Y=-21
    # WIDTH=657
    # HEIGHT=380
    # SCREEN=0

      # returns x, y, width, height
  end

  def parse_xprop_frame_extensions(output)
    # mschaefer@victoria:$ xprop _NET_FRAME_EXTENTS -id 75501325
    # _NET_FRAME_EXTENTS(CARDINAL) = 1, 1, 24, 1
    # returns left, right, top, bottom
  end

  def parse_xdotool_active_window(output)
    # mschaefer@victoria:$ xdotool getactivewindow
    # 75501325
    # returns string
  end
end
