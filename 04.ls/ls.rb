#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'

# 表示する列の数を定義
COLUMN_NUMBER = 3

all_files = false

opt = OptionParser.new
opt.on('-a', '--all [ITEM]', 'show all items') do
  all_files = true
end
opt.parse(ARGV)

# 配列の文字数を均一にする
def format_file_name(all_files)
  files = Dir.glob('*', all_files ? File::FNM_DOTMATCH : 0)
  max_length = files.max_by(&:length).size
  files.map { |file| file.ljust(max_length + 1) }
end

# 要素を display_number ずつに分けて縦表示対応した配列にする
def change_array_number(display_number, files)
  n = display_number
  add_blank_element = n - (files.size % n)
  files += [''] * add_blank_element
  array_for_right_position = files.each_slice(files.size / n).to_a
  array_for_right_position.transpose
end

files = format_file_name(all_files)

# 引数の数値で列数を変更
change_array_number(COLUMN_NUMBER, files).each do |row|
  puts row.join(' ')
end
