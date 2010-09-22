#!/usr/bin/env ruby
require "rubygems"
require "yaml"
require 'benchmark'
require 'date'

base = File.expand_path(File.dirname(__FILE__))
require File.join(base, "lib", "bricks")

data_file = File.join("data", "s1-exam-data.yaml")
data = YAML.load_file(data_file)

include Bricks::Helpers

table = Bricks::Table.new(data, :first_row_as_header => true)

table.delete_column_at(4)

array_to_money(table.columns['AMOUNT'])
array_to_money(table.columns['TARGET_AMOUNT'])
array_to_money(table.columns['AMTPINSPAID'])

table.columns['PROCEDURE_DATE'].each do |date|
  date.value = parse_date_us(date.value).strftime("%Y/%m/%d")
end

table.rows.select! do |row|
  limit = Date.new(2006,06,01) 
  procedure_date = parse_date_universal(row[0].value)
  (limit - procedure_date).to_i < 0
end

File.open(File.join("data", "s1-exam-data-transformed.yaml"), "w") do |file|
  file.write YAML.dump(table.to_a)
end

puts "Example Data Size: #{data.size}"
puts "Table Size: #{table.rows.size} "
