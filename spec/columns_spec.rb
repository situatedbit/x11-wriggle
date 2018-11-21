require 'columns'

describe :Columns do
  describe :snap_right do
    subject { Columns.new(width: 100) }

    it 'stays within the same column if at column start' do
        expect(subject.snap_right 100).to eq(1)
    end

    it 'moves one column to right if in the middle of a column' do
        expect(subject.snap_right 120).to eq(2)
    end

    it 'moves to column 1 if less than 0' do
        expect(subject.snap_right -20).to eq(0)
    end

    it 'extends the columns to the left' do
        expect(subject.snap_right -100).to eq(-1)
    end
  end

  describe :start do
    let(:column_width) { 100 }

    subject { Columns.new(width: column_width) }

    it 'is 0 for column 1' do
      expect(subject.start 1).to eq(0)
    end

    it 'is the column width for 2' do
      expect(subject.start 2).to eq(column_width)
    end

    it 'is the negative column width for -1' do
      expect(subject.start -1).to eq(-column_width)
    end

    it 'is 4 times the column width for 5' do
      expect(subject.start 5).to eq(column_width * 4)
    end
  end
end
