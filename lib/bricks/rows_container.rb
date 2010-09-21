require 'forwardable'

module Bricks
  class RowsContainer
    include Enumerable
    extend Forwardable
    attr_accessor :rows
    
    def_delegators :@rows, :empty?, :size
    
    def initialize
      @rows = []
    end
    def each
      @rows.each { |row| yield(row) }
    end
    def <<(array)
      @rows << Bricks::Row.new(array)
    end
    def [](index)
      @rows[index]
    end
  end
end