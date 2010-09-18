module Bricks
  class Table
    include Enumerable
    
    attr_accessor :options
    
    def initialize(*args)
      @options = extract_options!(args)
      self.column_names = @options[:column_names] 
      args.first.each_with_index do |row_data, index|
        self << Bricks::Row.new(row_data)
      end unless args.first.nil?
    end

    def columns
      @columns ||= []
    end
    def column(id)
      columns[id] ||= Bricks::Column.new
    end
    
    def column_names=(names)
      unless names.nil?
        names.each_with_index { |name, index| column(index).name = name }
      end
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
    def <<(new_row)
      rows << new_row
    end
    
  private
  
    def extract_options!(args)
      args.last.is_a?(::Hash) ? args.pop : {}
    end
  end
end