module Bricks
  module Helpers
    def monetize(value)
      value = value.insert(-3, ".") if value.size > 2
      value.insert(0, "$")
    end

    def array_to_money(array)
      array.each do |amount|
        amount.value = monetize(amount.value)
      end
    end
    def parse_date_us(value)
      month, day, year = value.split("/").map {|e| e.to_i}
      year += 2000 if year < 70 # arbitrary 
      Date.new(year, month, day)
    end
    def parse_date_universal(value)
      year, month, day = value.split("/").map {|e| e.to_i}
      year += 2000 if year < 70 # arbitrary 
      Date.new(year, month, day)
    end
  end
end