#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

BLANK_WIDTH = 8

params = ARGV.getopts('lwc')
file_names = ARGV

# オプションの有無による出力
def output(params, line_count, word_count, byte_amount, file_name)
  if !params['l'] && !params['w'] && !params['c']
    print "#{line_count}#{word_count}#{byte_amount} #{file_name}"
  else
    print line_count if params['l']
    print word_count if params['w']
    print byte_amount if params['c']
    print " #{file_name}"
  end
end

def wc(content)
  l_count = content.count("\n").to_s.rjust(BLANK_WIDTH)
  w_count = content.split(/\s+/).count.to_s.rjust(BLANK_WIDTH)
  c_count = content.bytesize.to_s.rjust(BLANK_WIDTH)

  { line_count: l_count, word_count: w_count, byte_amount: c_count }
end

# 通常のwcの出力
def file_wc(file_name, params)
  content = File.read(file_name)
  input = wc(content)
  output(params, input[:line_count], input[:word_count], input[:byte_amount], file_name)
  puts ''
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

# パイプによる出力
def pipe_with_wc(params)
  content = $stdin.read
  input = wc(content)
  output(params, input[:line_count], input[:word_count], input[:byte_amount], '')
end

def main(params, file_names)
  if file_names.empty?
    pipe_with_wc(params)
  else
    file_names.each { |file_name| file_wc(file_name, params) }
    total_wc(file_names) if file_names.count >= 2
  end
end

main(params, file_names)
