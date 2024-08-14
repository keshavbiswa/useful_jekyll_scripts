#!/usr/bin/env ruby
require 'date'
require 'yaml'

# the directory where your posts are located
POSTS_DIR = '_posts/'

errors = []

Dir.foreach(POSTS_DIR) do |path|
  next if ['.', '..'].include?(path)

  file_name = File.join(path)
  date_parts = file_name.split('-')[0..2].map(&:to_i)
  file_date = Date.new(*date_parts)
  yaml_data = String.new

  File.readlines(File.join(POSTS_DIR, file_name)).each_with_index do |line, index|
    if index.zero?
      next unless line.strip == '---'

      yaml_data << line
    elsif line.strip == '---'
      yaml_data << line
      break
    else
      yaml_data << line
    end
  end

  yaml = YAML.safe_load(yaml_data, permitted_classes: [Date, Symbol])
  puts "File date: #{file_date}"
  puts "post date: #{yaml['date']}"
  puts file_date == yaml['date']

  errors << { file_name:, file_date: file_date.to_s, post_date: yaml['date'].to_s } if file_date != yaml['date']
end

puts "Following file's date do not match with the post date:"
puts errors

puts "No of files: #{errors.size}"
