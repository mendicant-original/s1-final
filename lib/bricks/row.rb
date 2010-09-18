module Bricks
  class Row
    include Enumerable
    
    def initialize(data)
      data.each do |cell|
        cells << cell
      end
    end
    
    def cells
      @cells ||= []
    end
    
    def each
      cells.each do |cell|
        yield(cell)
      end
    end
  end
end