#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

BLANK_WIDTH = 8

options = ARGV.getopts('lwc')
default_options = { 'l' => true, 'w' => true, 'c' => true }
options = default_options unless options['l'] || options['w'] || options['c']
file_names = ARGV

def output(options, line_count, word_count, byte_amount, file_name)
  print line_count if options['l']
  print word_count if options['w']
  print byte_amount if options['c']
  print " #{file_name}"
end

def wc(content)
  l_count = content.count("\n").to_s.rjust(BLANK_WIDTH)
  w_count = content.split(/\s+/).count.to_s.rjust(BLANK_WIDTH)
  c_count = content.bytesize.to_s.rjust(BLANK_WIDTH)

  { line_count: l_count, word_count: w_count, byte_amount: c_count }
end

def wc_for_file_lists(file_name)
  content = file_name.empty? ? $stdin.read : File.read(file_name)
  wc(content)
end

def output_last_result(file_name, options)
  input = wc_for_file_lists(file_name)
  output(options, input[:line_count], input[:word_count], input[:byte_amount], file_name.empty? ? '' : file_name)
  puts '' if !file_name.empty?
end

def total_wc_files(file_names)
  total_l_count = 0
  total_w_count = 0
  total_c_count = 0

  file_names.each do |file_name|
    content = File.read(file_name)
    input = wc(content)
    total_l_count += input[:line_count].to_i
    total_w_count += input[:word_count].to_i
    total_c_count += input[:byte_amount].to_i
  end
  [total_l_count, total_w_count, total_c_count]
end

def total_wc(file_names)
  total = total_wc_files(file_names)
  all_sum = total.map { |count| count.to_s.rjust(8) }.join
  print all_sum
  print ' total'
end

def main(options, file_names)
  if file_names.empty?
    output_last_result('', options)
  else
    file_names.each { |file_name| output_last_result(file_name, options) }
    total_wc(file_names) if file_names.count >= 2
  end
end

main(options, file_names)
