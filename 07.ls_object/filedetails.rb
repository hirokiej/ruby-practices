#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'filename'
require 'etc'

class FileDetails
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

  def initialize(files)
    @file_stat = File.stat(files)
    @files = files
  end

  def filetype
    FILETYPE[@file_stat.mode.to_s(8)[0..1]] || ' '
  end

  def permission
    @file_stat.mode.to_s(8)[-3..].chars.map { |number| PERMISSION[number] }.join
  end

  def hard_link
    @file_stat.nlink.to_s
  end

  def owner_name
    Etc.getpwuid(@file_stat.uid).name
  end

  def group_name
    Etc.getgrgid(@file_stat.gid).name
  end

  def bite_size
    @file_stat.size.to_s
  end

  def update_time
    @file_stat.mtime.strftime('%-m %e %R')
  end

  def filename
    @files
  end
end
