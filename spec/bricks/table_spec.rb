require "spec_helper"

describe Bricks::Table do
  before(:each) do
    @data = [
        [ 1, "lucas", "lucasefe@hh.com"]
      ]
    @options = { :header => %w(id name email) }
  end
  it "should be initializable with no arguments" do
    table = Bricks::Table.new
    table.should be_empty
    table.options.should == {}
  end
  context "being initialized" do
    it "should be initializable with and array of arrays" do
      table = Bricks::Table.new(@data)
      table[0].should == @data[0]
    end
    it "should be able to receive only options, with no data" do
      table = Bricks::Table.new(@options)
      table.options.should == @options
    end
    it "should be able to receive data and options" do
      table = Bricks::Table.new(@data, @options)
      table[0].should == @data[0]
      table.options.should == @options
    end
  end
  context "initialized empty" do
    before(:each) do
      @table = Bricks::Table.new
    end
    it "should allow appending" do
      @table << [1, "Rolando", "rola@tony.com"]
      @table.should have(1).rows
    end
  end
end