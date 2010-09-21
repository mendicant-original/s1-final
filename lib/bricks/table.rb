module Bricks
  class Table
    include Enumerable
    attr_accessor :options
    attr_reader :rows, :columns
    
    def initialize(*args)
      @options = extract_options!(args)
      @rows ||= Bricks::Index.new
      @columns ||= Bricks::Index.new
            
      columns.header = @options[:header] if @options[:header]
      
      unless args.first.nil?
        data = args.first.dup # to avoid alter original data  
        if @options[:first_row_as_header]
          columns.header = data.shift
        end
      
        data.each_with_index do |row, index|
          add_row row
        end
      end
    end
    
    def add_row(new_row)
      add_and_update(new_row, rows, columns)
    end
    
    def insert_row_at(position, row)
      insert_at_and_update(position, row, rows, columns)
    end
    
    def add_column(new_column)
      add_and_update(new_column, columns, rows)
    end
    
    def insert_column_at(position, column)
      insert_at_and_update(position, column, columns, rows)
    end
    
    def each
      rows.each do |row|
        yield(row)
      end
    end
    
    def empty?
      rows.empty?
    end
    
  private
    def build_cell(value)
      value.kind_of?(Bricks::Cell) ? value : Bricks::Cell.new(value) 
    end
    def extract_options!(args)
      args.last.is_a?(::Hash) ? args.pop : {}
    end
    def add_and_update(array, primary, secondary )
      new_array = []
      array.each_with_index do |value, index| 
        cell = build_cell(value)
        new_array << cell 
        secondary[index] ||= []
        secondary[index] << cell
      end
      primary << new_array
    end
    def insert_at_and_update(position, array, primary, secondary )
      new_array = []
      array.each_with_index do |value, index| 
        cell = build_cell(value)
        new_array << cell 
        secondary[index] ||= []
        secondary[index].insert(position, cell)
      end
      primary.insert(position, new_array)
    end
  end
end