#!/usr/bin/env ruby
require "rubygems"
require "yaml"
require 'benchmark'


base = File.expand_path(File.dirname(__FILE__))
require File.join(base, "lib", "bricks")

data_file = File.join("data", "s1-exam-data.yaml")
data = YAML.load_file(data_file)

table = Bricks::Table.new(data, :first_row_as_header => true)

puts "Example Data Size: #{data.size}"
puts "Table Size: #{table.rows.size} "
