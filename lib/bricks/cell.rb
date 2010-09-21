module Bricks
  class Cell
    include Comparable
    attr_accessor :value
    def initialize(value)
      @value = value
    end
    def <=>(anOther)
      self.value <=> anOther
    end
  end
end