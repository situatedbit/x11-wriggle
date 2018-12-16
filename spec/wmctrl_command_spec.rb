require 'wmctrl_command'

describe :WmctrlCommand do
  describe :x do
    it 'defaults to -1' do
      expect(WmctrlCommand.new.x).to eq(-1)
    end
  end

  describe :y do
    it 'defaults to -1' do
      expect(WmctrlCommand.new.y).to eq(-1)
    end
  end



  describe :width do
    it 'defaults to -1' do
      expect(WmctrlCommand.new.width).to eq(-1)
    end
  end

  describe :height do
    it 'defaults to -1' do
      expect(WmctrlCommand.new.height).to eq(-1)
    end
  end

  describe :to_s do
    let :matcher { /wmctrl -r :ACTIVE: -e (?<gravity>\d),(?<x>-?\d+),(?<y>-?\d+),(?<width>-?\d+),(?<height>-?\d+)/ }

    it 'specifies 0 gravity' do
        c = WmctrlCommand.new

        expect(c.to_s.match(matcher)[:gravity]).to eq('0')
    end

    it 'includes x' do
      c = WmctrlCommand.new x: 42

      expect(c.to_s.match(matcher)[:x]).to eq('42')
    end

    it 'includes y' do
      c = WmctrlCommand.new y: 43

      expect(c.to_s.match(matcher)[:y]).to eq('43')
    end

    it 'includes width' do
      c = WmctrlCommand.new width: 44

      expect(c.to_s.match(matcher)[:width]).to eq('44')
    end

    it 'includes height' do
      c = WmctrlCommand.new height: 45

      expect(c.to_s.match(matcher)[:height]).to eq('45')
    end
  end
end
