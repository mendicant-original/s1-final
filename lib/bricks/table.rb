module Bricks
  class Table
    include Enumerable
    
    attr_accessor :options
    
    def initialize(*args)      
      @options = extract_options!(args)      
      
      args.first.each do |row|
        rows << row
      end unless args.first.nil?
    end
    
    def rows
      @rows ||= []
    end
    
    def each
      rows.each do |row|
        yield(row)
      end
    end
    
    def empty?
      rows.empty?
    end
    
    def [](index)
      rows[index]
    end
    def <<(value)
      rows << value
    end
    
  private
  
    def extract_options!(args)
      args.last.is_a?(::Hash) ? args.pop : {}
    end
  end
end