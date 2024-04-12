#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require 'etc'

# 表示する列の数を定義
COLUMN_NUMBER = 3

PERMISSION = {
  '0' => '---',
  '1' => '--x',
  '2' => '-w-',
  '3' => '-wx',
  '4' => 'r--',
  '5' => 'r-x',
  '6' => 'rw-',
  '7' => 'rwx'
}.freeze

FILETYPE = {
  '01' => 'p',
  '02' => 'c',
  '04' => 'd',
  '06' => 'b',
  '10' => '-',
  '12' => 'l',
  '14' => 's'
}.freeze

options = {
  all_files: false,
  reverse_order: false,
  detail_items: false
}
opt = OptionParser.new
opt.on('-a', '--all [ITEM]', 'show all items') do
  options[:all_files] = true
end

opt.on('-r', '--reverse [ITEM]', 'reverse order of items') do
  options[:reverse_order] = true
end

opt.on('-l', '--long [ITEM]', 'show detailed explanaion of items') do
  options[:detail_items] = true
end

opt.parse(ARGV)

# -lの最長可変数
def max_length(files_stats)
  hard_links = []
  owners = []
  groups = []
  sizes = []

  files_stats.each do |file|
    hard_links << file.nlink.to_s
    owners << Etc.getpwuid(file.uid).name
    groups << Etc.getgrgid(file.gid).name
    sizes << file.size.to_s
  end
  {
    link: hard_links.max_by(&:length).length,
    owner: owners.max_by(&:length).length,
    group: groups.max_by(&:length).length,
    size: sizes.max_by(&:length).length
  }
end

# -lの出力を作るメソッド
def long_format
  files = Dir.glob('*')
  max_length = max_length(files.map { |f| File.stat(f) })
  files.each do |file|
    stat = File.stat(file)
    filetype = FILETYPE[stat.mode.to_s(8)[0..1]]
    permission = stat.mode.to_s(8)[-3..].chars.map { |number| PERMISSION[number] }.join
    hard_link = stat.nlink.to_s.rjust(max_length[:link])
    owner_name = Etc.getpwuid(stat.uid).name.rjust(max_length[:owner])
    group_name = Etc.getgrgid(stat.gid).name.rjust(max_length[:group])
    bite_size = stat.size.to_s.rjust(max_length[:size])
    update_time = stat.mtime.strftime('%-m %e %R')
    puts "#{filetype}#{permission} #{hard_link} #{owner_name} #{group_name} #{bite_size}  #{update_time} #{file}"
  end
end

# 配列の文字数を均一にする
def format_file_name(options)
  files = Dir.glob('*', options[:all_files] ? File::FNM_DOTMATCH : 0)
  files = files.reverse if options[:reverse_order]
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

def main(options)
  files = format_file_name(options)
  if options[:detail_items] == true
    long_format
  else
    # 引数の数値で列数を変更
    change_array_number(COLUMN_NUMBER, files).each do |row|
      puts row.join(' ')
    end
  end
end

main(options)
