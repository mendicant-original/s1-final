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
    def to_s
      value
    end
    def inspect
      to_s
    end
  end
end