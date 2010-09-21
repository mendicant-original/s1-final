module Bricks
  class Index < Array
    def header
      @header ||= Hash.new { |hash, key| hash[key] = Bricks::Column.new  }
    end
    def header=(names)
      unless names.nil?
        names.each_with_index { |name, index| header[name].index =  index }
      end
    end
    def [](index)
      index = index_for(index)
      super(index)
    end
  private
    def index_for(index)
      if index.kind_of?(String) and !header[index].nil?
        puts header[index].index
        header[index].index
      else
        index
      end
    end
  end
end