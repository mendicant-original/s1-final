module Bricks
  class Table
    include Enumerable
    attr_accessor :options

    def initialize(*args)
      @options = extract_options!(args)
      self.header = @options[:header] 
      args.first.each_with_index do |row_data, index|
        add_row row_data
      end unless args.first.nil?
    end

    def add_row(new_row)
      add_and_update(new_row, rows, columns)
    end
    def add_column(new_column)
      add_and_update(new_column, columns, rows)
    end
    def rows
      @rows ||= []
    end
    
    def columns
      @columns ||= []
    end
    def each
      rows.each do |row|
        yield(row)
      end
    end
    
    def empty?
      rows.empty?
    end
    def header
      @header ||= Hash.new { |hash, key| hash[key] = Bricks::Column.new }
    end

    def header=(names)
      unless names.nil?
        names.each_with_index { |name, index| header[index].name = name }
      end
    end
    
  private
    def build_cell(value)
      value.kind_of?(Bricks::Cell) ? value : Bricks::Cell.new(value) 
    end
    def extract_options!(args)
      args.last.is_a?(::Hash) ? args.pop : {}
    end
    def add_and_update(array, collection, secondary_collection )
      new_array = []
      array.each_with_index do |value, index| 
        cell = build_cell(value)
        new_array << cell 
        secondary_collection[index] ||= []
        secondary_collection[index] << cell
      end
      collection << new_array
    end
  end
end