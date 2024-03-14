#!/usr/bin/env ruby
# frozen_string_literal: true

# 配列の文字数を均一にする
def format_file_name
  files = Dir.glob("*")
  max_length = files.max_by(&:length).size
  files.map { |file| file.ljust(max_length + 1) }
end

# 要素を display_number ずつに分けて縦表示対応した配列にする
def change_array_number(display_number)
  n = display_number
  files = format_file_name
  add_blank_element = n - (files.size % n)
  files += [''] * add_blank_element
  array_for_right_position = files.each_slice(files.size / n).to_a
  array_for_right_position.transpose
end

# 引数の数値で列数を変更
change_array_number(3).each do |row|
  puts row.join(' ')
end
