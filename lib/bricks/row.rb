module Bricks
  class Row
    attr_accessor :cells
    include Enumerable
    # include Comparable
    def initialize(array = [])
      @cells = []
      array.each { |value| add_cell(value) }
    end
    def each
      @cells.each { |cell| yield(cell) }
    end
    def to_a
      @cells.map { |cell| cell.value }
    end
  private
    def add_cell(value)
      @cells << (value.kind_of?(Bricks::Cell) ? value : Bricks::Cell.new(value))
    end
  end
end