module Bricks
  class Column
    attr_accessor :name, :index
    def to_s
      "#{name} => #{index} "
    end
  end
end