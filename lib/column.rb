class Column
  attr_reader :left, :right

  def initialize(left, right)
    @left = left
    @right = right
  end

  def includes(x)
    @left <= x and x <= @right
  end
end
