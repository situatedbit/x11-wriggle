require 'stretch'
require 'columns'

describe :Stretch do
  describe :left do
    let(:columns) { Columns.new(:width => 100) }

    it 'will be -1 when direction is right' do
      window = instance_double('Window')

      expect(Stretch.new(window: window, columns: columns).left).to eq(-1)
    end

    it 'when direction is to left, will continue past origin point' do
      window = instance_double('Window', :left => 0)

      expect(Stretch.new(window: window, columns: columns, to_right: false).left).to eq(-columns.width)
    end

    it 'when direction is to left, will be the next column to the left of the current window column' do
      window = instance_double('Window', :left => 240)

      expect(Stretch.new(window: window, columns: columns, to_right: false).left).to eq(200)
    end

    it 'when direction is to left, will be the next column to the left if the window is already at a column start' do
       window = instance_double('Window', :left => 200)

       expect(Stretch.new(window: window, columns: columns, to_right: false).left).to eq(100)
    end

    it 'when direction is to the left, will continue moving beyond origin point' do
      window = instance_double('Window', :left => 0)

      expect(Stretch.new(window: window, columns: columns, to_right: false).left).to eq(-100)
    end
  end

  describe :right

  describe :width

  describe :height
end
