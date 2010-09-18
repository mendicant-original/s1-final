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
      table.rows[0].to_a.should == @data[0]
    end
    
    it "should be able to receive only options, with no data" do
      table = Bricks::Table.new(@options)
      table.options.should == @options
    end
    
    it "should be able to receive data and options" do
      table = Bricks::Table.new(@data, @options)
      table.rows[0].to_a.should == @data[0]
      table.options.should == @options
    end
    
  end
  context "initialized empty" do
    
    it "should allow appending" do
      @table = Bricks::Table.new
      @table << [1, "Rolando", "rola@tony.com"]
      @table.should have(1).rows
    end
    
  end
  context "columns" do
    
    it "should allow to set the column name of a given column" do
      @table = Bricks::Table.new(@data)
      @table.column(1).name = 'Name'
      @table.column(1).name.should == 'Name'
    end
    
    it "should set column names on initialization" do
      @table = Bricks::Table.new(@data, :column_names => %w(id Name Email))
      @table.column(0).name.should == 'id'
      @table.column(1).name.should == 'Name'
      @table.column(2).name.should == 'Email'
    end
    
  end
end