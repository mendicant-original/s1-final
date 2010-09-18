module Bricks
  class Table
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
  private
    def extract_options!(args)
      args.last.is_a?(::Hash) ? args.pop : {}
    end
  end
end