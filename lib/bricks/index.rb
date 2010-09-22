require 'delegate'

module Bricks
  class Index < DelegateClass(Array)
    
    def initialize
      super(Array.new)
    end
    
    def header
      @header ||= Hash.new { |hash, key| hash[key] = Bricks::Column.new  }
    end
    
    def header=(names)
      unless names.nil?
        names.each_with_index { |name, index| header[name].index =  index }
      end
    end
    
    def [](index)
      super(index_for(index))
    end
    
    def to_a
      super.map {|e| e.map { |a| a.value  } }
    end
    
    private
  
    def index_for(index)
      if index.kind_of?(String) and !header[index].nil?
        header[index].index
      else
        index
      end
    end
  end
end