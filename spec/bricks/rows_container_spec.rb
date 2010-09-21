require "spec_helper"

describe Bricks::RowsContainer do
  before(:each) do
    @rows = Bricks::RowsContainer.new
    @rows << [ 1, 2, 3]
  end
  it "should add elements as Cells objects" do

    @rows.each do |row|
      row.each { |cell| cell.should be_a_kind_of(Bricks::Cell) }
    end
  end
  it "should get rows by index" do
    @rows[0].to_a.should == [ 1, 2, 3]
  end
  it "should return nil when row not found" do
    @rows[1].should == nil
  end
end