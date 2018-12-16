require 'stretch'
require 'column_layout'

describe :Stretch do
  describe :left do
    let(:layout) { ColumnLayout.new(width: 100, count: 10) }

    context 'side is right' do
      it 'will be window left' do
        window = instance_double('Window', left: 39)

        expect(Stretch.new(window: window, layout: layout, side: Stretch::Right).left).to eq(39)
      end
    end

    context 'side is left' do
      let(:params) { { layout: layout, to_right: false, side: Stretch::Left } }

      it 'will be 0 if window left is negative' do
        window = instance_double('Window', :left => -10)

        expect(Stretch.new(params.merge(window: window)).left).to eq(0)
      end

      it 'will be 0 if window left is 0' do
        window = instance_double('Window', :left => 0)

        expect(Stretch.new(params.merge(window: window)).left).to eq(0)
      end

      it 'will be current column if window left is in middle of column' do
        window = instance_double('Window', :left => 15)

        expect(Stretch.new(params.merge(window: window)).left).to eq(10)
      end

      it 'will be one column to left if window left is on start of column' do
        window = instance_double('Window', :left => 30)

        expect(Stretch.new(params.merge(window: window)).left).to eq(20)
      end

      it 'will be last column if window left is beyond layout width' do
        window = instance_double('Window', :left => 120)

        expect(Stretch.new(params.merge(window: window)).left).to eq(90)
      end

      context 'compressing' do
        let(:compressing_params) { params.merge action: Stretch.compress }

        it 'will be one column to the right if window left is in middle of column' do
          window = instance_double('Window', :left => 15)

          expect(Stretch.new(compressing_params.merge(window: window)).left).to eq(20)
        end

        it 'will be one column to the right if window left is at the column start' do
          window = instance_double('Window', :left => 20)

          expect(Stretch.new(compressing_params.merge(window: window)).left).to eq(30)
        end
      end
    end
  end

  describe :right do
    let(:layout) { ColumnLayout.new(width: 100, count: 10) }

    context 'side is left' do
      it 'will be window right when direction is left' do
        window = instance_double('Window', right: 39)

        expect(Stretch.new(window: window, layout: layout, side: Stretch::Left).right).to eq(39)
      end
    end

    context 'side is right' do
      let(:params) { { layout: layout, side: Stretch::Right } }

      it 'will be end of column 1 if window right is negative' do
        window = instance_double('Window', :right => -10)

        expect(Stretch.new(params.merge(window: window)).right).to eq(9)
      end

      it 'will be end of column 1 if window right is 0' do
        window = instance_double('Window', :right => 0)

        expect(Stretch.new(params.merge(window: window)).right).to eq(9)
      end

      it 'will be end of current column if window right is in middle of column' do
        window = instance_double('Window', :right => 15)

        expect(Stretch.new(params.merge(window: window)).right).to eq(19)
      end

      it 'will be end of one column to right if window right is on end of column' do
        window = instance_double('Window', :right => 29)

        expect(Stretch.new(params.merge(window: window)).right).to eq(39)
      end

      it 'will be last column if window right is beyond layout width' do
        window = instance_double('Window', :right => 120)

        expect(Stretch.new(params.merge(window: window)).right).to eq(99)
      end

      context 'compressing' do
        let(:compressing_params) { params.merge action: Stretch.compress }

        it 'will be one column to the left if window right is in middle of column' do
          window = instance_double('Window', :right => 45)

          expect(Stretch.new(compressing_params.merge(window: window)).right).to eq(39)
        end

        it 'will be one column to the left if window right is at the column end' do
          window = instance_double('Window', :right => 39)

          expect(Stretch.new(compressing_params.merge(window: window)).right).to eq(29)
        end
      end
    end
  end
end
