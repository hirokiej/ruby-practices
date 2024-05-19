#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

BLANK_WIDTH = 8

options = ARGV.getopts('lwc')
default_options = { 'l' => true, 'w' => true, 'c' => true }
options = default_options unless options['l'] || options['w'] || options['c']
file_names = ARGV

def output_wc_info(options, line_count, word_count, byte_count, file_name)
  print line_count if options['l']
  print word_count if options['w']
  print byte_count if options['c']
  print " #{file_name}"
end

def count_wc(content)
  words = content.split(/\s+/).reject(&:empty?)
  l_count = content.count("\n").to_s.rjust(BLANK_WIDTH)
  w_count = words.count.to_s.rjust(BLANK_WIDTH)
  c_count = content.bytesize.to_s.rjust(BLANK_WIDTH)
  { line_count: l_count, word_count: w_count, byte_count: c_count }
end

def wc_for_file_lists(file_name)
  content = file_name.empty? ? $stdin.read : File.read(file_name)
  count_wc(content)
end

def output_file_lists(file_name, options)
  input = wc_for_file_lists(file_name)
  output_wc_info(options, input[:line_count], input[:word_count], input[:byte_count], file_name.empty? ? '' : file_name)
  puts unless file_name.empty?
end

def calculate_total_wc_files(file_names)
  total_l_count = 0
  total_w_count = 0
  total_c_count = 0

  file_names.each do |file_name|
    content = File.read(file_name)
    input = count_wc(content)
    total_l_count += input[:line_count].to_i
    total_w_count += input[:word_count].to_i
    total_c_count += input[:byte_count].to_i
  end
  [total_l_count, total_w_count, total_c_count]
end

def output_total_wc(file_names)
  total = calculate_total_wc_files(file_names)
  all_sum = total.map { |count| count.to_s.rjust(8) }.join
  print all_sum
  print ' total'
end

def main(options, file_names)
  if file_names.empty?
    output_file_lists('', options)
  else
    file_names.each { |file_name| output_file_lists(file_name, options) }
    output_total_wc(file_names) if file_names.count >= 2
  end
end

main(options, file_names)
