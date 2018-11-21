xdotool
wmctrl

get window dimensions

# stretch
```
stretch --left
stretch --right (default)
```

The increments would probably have to be divisions of display size (maybe, 10%?), so I could easily apply the opposite operation to an adjacent window to complete the tiling

`([ ][ ]) -> ([][  ])`

# center
```
center (defaults to both) (would not resize)
center --horiz
center --vert
```

horizontally and/or vertically

# three columns
```
column [column_count] [destination_column]
column 3 2 (move to second column of three column layout)
column 4 1 (move to first column of four column layout)
column 1 1 (full size of screen)
```

Eventually I could see this involving spans, and then stretch could do some _relative_ adjustments.

Like halving, but can specify keyboard shortcuts to move windows between this arrangement: `[][][]`

# four columns


# Notes on wmctrl

Get ID of active window:
```
mschaefer@victoria:$ xdotool getactivewindow
75501325
```

Get geometry, ignoring decoration/borders
```
mschaefer@victoria:$ xdotool getwindowgeometry --shell 75501325
WINDOW=75501325
X=44
Y=-21
WIDTH=657
HEIGHT=380
SCREEN=0
```

Get border width (left, right, top, bottom)
```
mschaefer@victoria:$ xprop _NET_FRAME_EXTENTS -id 75501325
_NET_FRAME_EXTENTS(CARDINAL) = 1, 1, 24, 1
```

```
mschaefer@victoria:$ wmctrl -p -G -l
0x01200004 -1 2080   0    0    42   768  victoria xfce4-panel
0x01400003 -1 2084   0    0    1366 768  victoria Desktop
0x03000025  0 14723  42   0    1324 768  victoria Google Calendar - Wednesday, November 21, 2018, today - Mozilla Firefox
0x04800004  0 16205  44   48   657  740  victoria Terminal - mschaefer@victoria: ~/data/development/windows
0x04a00001  0 16646  706  48   660  743  victoria notes.md — ~/src/windows — Atom
0x048003a7  0 16205  314  48   1049 740  victoria Terminal - mschaefer@victoria: ~/data/development/windows
```

Get display size:
```
mschaefer@victoria:$ xwininfo -shape  -root

xwininfo: Window id: 0x101 (the root window) (has no name)

  Absolute upper-left X:  0
  Absolute upper-left Y:  0
  Relative upper-left X:  0
  Relative upper-left Y:  0
  Width: 1366
  Height: 768
  Depth: 24
  Visual: 0x20
  Visual Class: TrueColor
  Border width: 0
  Class: InputOutput
  Colormap: 0x22 (installed)
  Bit Gravity State: ForgetGravity
  Window Gravity State: NorthWestGravity
  Backing Store State: NotUseful
  Save Under State: no
  Map State: IsViewable
  Override Redirect State: no
  Corners:  +0+0  -0+0  -0-0  +0-0
  -geometry 1366x768+0+0

  No window shape defined
  No border shape defined
```

gravity,x,y,w,h (gravity: 0); -1 persists current value
wmctrl -r :ACTIVE: -e 0,0,0,200,800
wmctrl -r :ACTIVE: -e 0,-1,-1,800,-1
