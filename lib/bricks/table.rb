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

    def delete_row_at(position)
      delete_at_and_update(position, rows, columns)
    end
    
    def add_column(new_column)
      add_and_update(new_column, columns, rows)
    end
    
    def insert_column_at(position, column)
      insert_at_and_update(position, column, columns, rows)
    end
    
    def delete_column_at(position)
      delete_at_and_update(position, columns, rows)
    end
    
    def each
      rows.each do |row|
        yield(row)
      end
    end
    
    def empty?
      rows.empty?
    end
    def to_a
      rows.to_a
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
      with_cells_in(array) do |cell, index|
        new_array << cell 
        secondary[index] ||= []
        secondary[index] << cell
      end
      primary << new_array
    end
    def insert_at_and_update(position, array, primary, secondary )
      new_array = []
      with_cells_in(array) do |cell, index|
        new_array << cell 
        secondary[index] ||= []
        secondary[index].insert(position, cell)
      end
      primary.insert(position, new_array)
    end
    def delete_at_and_update(position, primary, secondary )
      secondary.each { |a| a.delete_at(position)  }  
      primary.delete_at(position)
    end
    def with_cells_in(array)
      array.each_with_index do |value, index| 
        yield(build_cell(value), index)
      end
    end
  end
end