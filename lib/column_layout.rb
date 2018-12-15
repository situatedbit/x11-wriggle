require_relative 'column'

# columns are 0-based. The starting coordinate of column 0 is 0.
# Values are clipped that fall outside the width of the layout.
class ColumnLayout
  attr_reader :columns

  def initialize(params = {})
    @count = params.fetch(:count) # number of columns in layout
    @width = params.fetch(:width) # width of the layout in pixels

    @columns = (0...@count).to_a.map { |index| Column.new(column_left(index), column_left(index + 1) - 1) }
  end

  def column_index(x)
    return 0 if x < 0
    return @columns.size - 1 if x >= @width

    @columns.find_index { |column| column.includes x }
  end

  def column(x)
    @columns[column_index(x)]
  end

  private
  def column_left(index)
    (index * @width / @count.to_f).floor
  end
end
