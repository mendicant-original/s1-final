require "spec_helper"

describe Bricks::Table do
  before(:each) do
    @simple_data = [
        [1,2,3]
      ]
  end
  it "should be initializable with no arguments" do
    lambda { 
      table = Bricks::Table.new
    }.should_not raise_error
  end
  context "being initialized with data" do
    it "should be initializable with and array of arrays" do
      lambda { 
        table = Bricks::Table.new(@simple_data)
      }.should_not raise_error
    end    
  end
end