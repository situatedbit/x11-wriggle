class Column
  attr_reader :left, :right

  def initialize(left, right)
    @left = left
    @right = right
  end

  def include?(x)
    @left <= x and x <= @right
  end
end
