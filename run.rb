#!/usr/bin/env ruby
require "rubygems"
require "yaml"
require 'benchmark'
require 'date'

base = File.expand_path(File.dirname(__FILE__))
require File.join(base, "lib", "bricks")

input_file = "s1-exam-data.yaml"
output_file = "s1-exam-data-transformed.yaml"

data = YAML.load_file(input_file)

# Include helper methods
include Bricks::Helpers

# Load table
table = Bricks::Table.new(data, :first_row_as_header => true)

# Delete COUNT column
table.delete_column_at(4)

# Convert money columns
array_to_money(table.columns['AMOUNT'], table.columns['TARGET_AMOUNT'], table.columns['AMTPINSPAID'])

# Convert PROCEDURE_DATE field to YYYY/MM/DD
table.columns['PROCEDURE_DATE'].each do |date|
  date.value = parse_date_us(date.value).strftime("%Y/%m/%d")
end

# Remove Old Rows
date_limit = Date.new(2006,06,01) 
table.rows.select! do |row|
  procedure_date = parse_date_universal(row[0].value)
  (date_limit - procedure_date).to_i < 0
end

# Save to file
File.open(output_file, "w") do |file|
  file.write YAML.dump(table.to_a)
end

puts "Example Data Size: #{data.size}"
puts "Table Size: #{table.rows.size} "
