require 'column_layout'

describe :ColumnLayout do
  describe :columns do
    context 'there is a single column' do
      subject { ColumnLayout.new(width: 100, count: 1).columns }

      it 'is a single column' do
        expect(subject.size).to eq(1)
      end

      it 'begins with 0' do
        expect(subject.first.left).to eq(0)
      end

      it 'ends with 99' do
        expect(subject.last.right).to eq(99)
      end
    end

    context 'count divides width evenly' do
      subject { ColumnLayout.new(width: 100, count: 2).columns }

      it 'size matches count' do
        expect(subject.size).to eq(2)
      end

      it 'begins with 0' do
        expect(subject.first.left).to eq(0)
      end

      it 'ends with 99' do
        expect(subject.last.right).to eq(99)
      end
    end

    context 'count does not divide width evenly' do
      # 0 16 33 50 66 83
      subject { ColumnLayout.new(width: 100, count: 6).columns }

      it 'size matches count' do
        expect(subject.size).to eq(6)
      end

      it 'begins with 0' do
        expect(subject.first.left).to eq(0)
      end

      it 'creates correct boundary on the low end' do
        expect(subject[2].left).to eq(33)
      end

      it 'creates correct boundary on the high end' do
        expect(subject[2].right).to eq(49)
      end

      it 'ends with 99' do
        expect(subject.last.right).to eq(99)
      end
    end
  end

  describe :column_index do
    # 0 16 33 50 66 83
    subject { ColumnLayout.new(width: 100, count: 6) }

    it 'is column 0 if negative' do
      expect(subject.column_index(-5)).to eq(0)
    end

    it 'is column 0 if 0' do
      expect(subject.column_index(0)).to eq(0)
    end

    it 'matches column start' do
      expect(subject.column_index(50)).to eq(3)
    end

    it 'matches column middle' do
      expect(subject.column_index(55)).to eq(3)
    end

    it 'matches column end' do
      expect(subject.column_index(65)).to eq(3)
    end

    it 'is last column if last pixel in layout width' do
      expect(subject.column_index(99)).to eq(5)
    end

    it 'is last column if greater than layout width' do
      expect(subject.column_index(9999)).to eq(5)
    end
  end
end
