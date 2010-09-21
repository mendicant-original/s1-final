require "spec_helper"

describe Bricks::Table do
  before(:each) do
    @data = [
        [ 1, "lucas", "lucas@vera.com"],
        [ 2, "tam", "tam@vera.com"]
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
      table.rows[0].should == @data[0]
    end
    
    it "should be able to receive only options, with no data" do
      table = Bricks::Table.new(@options)
      table.options.should == @options
    end
    
    it "should be able to receive data and options" do
      table = Bricks::Table.new(@data, @options)
      table.rows[0].should == @data[0]
      table.options.should == @options
    end
    
  end
  it "should allow appending" do
    @table = Bricks::Table.new
    @table.add_row [1, "Rolando", "rola@tony.com"]
    @table.should have(1).rows
  end
  it "should store Cell objects" do
    @table = Bricks::Table.new
    @table.add_row [1, "Rolando", "rola@tony.com"]
    @table.rows.each do |row|
      row.each { |cell| cell.should be_a_kind_of(Bricks::Cell) }
    end
  end
  it "should keep the columns updated when adding rows"  do
    data = [1, "Rolando", "rola@tony.com"]
    @table = Bricks::Table.new
    @table.add_row data
    @table.columns.should have(3).elements
    @table.columns[0][0].should == data[0]
    @table.columns[1][0].should == data[1]
    @table.columns[2][0].should == data[2]

  end
  context "column names" do
    it "should allow to set the column name of a given column" do
      @table = Bricks::Table.new(@data)
      @table.header[1].name = 'Name'
      @table.header[1].name.should == 'Name'
    end
  #   
  #   it "should set column names on initialization" do
  #     @table = Bricks::Table.new(@data, :header => %w(id Name Email))
  #     @table.header[0].name.should == 'id'
  #     @table.header[1].name.should == 'Name'
  #     @table.header[2].name.should == 'Email'
  #   end
  end
  
  context "columns" do
    before do
      @table = Bricks::Table.new(@data)
    end
    it "should allow you to get a given column by index" do
      @table.columns[1].should == ['lucas', 'tam']
    end
    # it "should allow you to get a given column by name" do
    #   @table.columns['Nombre'].should == [['lucas']]
    # end
  end
end