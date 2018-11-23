require 'parser'

describe :Parser do
  describe :parse_window do
    it 'throws an exception if it cannot parse the output' do
      expect { Parser.parse_window '' }.to raise_error(Parser::ParserError)
    end

    it 'parses x' do
      output = <<~STDOUT
        Absolute upper-left X:  43
        Absolute upper-left Y:  24
        Relative upper-left X:  1
        Relative upper-left Y:  42
        Width: 657
        Height: 380
        Depth: 32
        Visual: 0x72
      STDOUT

      expect(Parser.parse_window(output)[:x]).to eq(43)
    end

    it 'parses negative x' do
      output = <<~STDOUT
        Absolute upper-left X:  -43
        Absolute upper-left Y:  24
        Relative upper-left X:  1
        Relative upper-left Y:  42
        Width: 657
        Height: 380
        Depth: 32
        Visual: 0x72
      STDOUT

      expect(Parser.parse_window(output)[:x]).to eq(-43)
    end

    it 'parses y' do
      output = <<~STDOUT
        Absolute upper-left X:  43
        Absolute upper-left Y:  240
        Relative upper-left X:  1
        Relative upper-left Y:  42
        Width: 657
        Height: 380
        Depth: 32
        Visual: 0x72
      STDOUT

      expect(Parser.parse_window(output)[:y]).to eq(240)
    end

    it 'parses negative y' do
      output = <<~STDOUT
        Absolute upper-left X:  43
        Absolute upper-left Y:  -2
        Relative upper-left X:  1
        Relative upper-left Y:  24
        Width: 657
        Height: 380
        Depth: 32
        Visual: 0x72
      STDOUT

      expect(Parser.parse_window(output)[:y]).to eq(-2)
    end

    it 'parses width' do
      output = <<~STDOUT
        Absolute upper-left X:  43
        Absolute upper-left Y:  24
        Relative upper-left X:  1
        Relative upper-left Y:  24
        Width: 657
        Height: 380
        Depth: 32
        Visual: 0x72
        Visual Class: TrueColor
        Border width: 0
        Class: InputOutput
      STDOUT

      expect(Parser.parse_window(output)[:width]).to eq(657)
    end

    it 'parses height' do
      output = <<~STDOUT
        Absolute upper-left X:  43
        Absolute upper-left Y:  24
        Relative upper-left X:  1
        Relative upper-left Y:  24
        Width: 657
        Height: 380
        Depth: 32
      STDOUT

      expect(Parser.parse_window(output)[:height]).to eq(380)
    end
  end

  describe :parse_borders do
    it 'throws an exception if it cannot parse the output' do
      expect { Parser.parse_borders '' }.to raise_error(Parser::ParserError)
    end

    it 'parses left' do
      output = '_NET_FRAME_EXTENTS(CARDINAL) = 0, 10, 24, 100'

      expect(Parser.parse_borders(output)[:left]).to eq(0)
    end

    it 'parses right' do
      output = '_NET_FRAME_EXTENTS(CARDINAL) = 1, 10, 24, 100'

      expect(Parser.parse_borders(output)[:right]).to eq(10)
    end

    it 'parses top' do
      output = '_NET_FRAME_EXTENTS(CARDINAL) = 1, 10, 24, 100'

      expect(Parser.parse_borders(output)[:top]).to eq(24)
    end

    it 'parses bottom' do
      output = '_NET_FRAME_EXTENTS(CARDINAL) = 1, 10, 24, 100'

      expect(Parser.parse_borders(output)[:bottom]).to eq(100)
    end
  end
end
