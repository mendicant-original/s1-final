module Bricks
  class Table
    include Enumerable
    
    attr_accessor :options
    
    def initialize(*args)
      @options = extract_options!(args)
      self.header = @options[:header] 
      args.first.each_with_index do |row_data, index|
        self << Bricks::Row.new(row_data)
      end unless args.first.nil?
    end

    def header
      @header ||= Hash.new { |hash, key| hash[key] = Bricks::Column.new }
    end
    
    def header=(names)
      unless names.nil?
        names.each_with_index { |name, index| header[index].name = name }
      end
    end
    
    def rows
      @rows ||= []
    end
    
    # def columns
    #   rows.transpose
    # end
    
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