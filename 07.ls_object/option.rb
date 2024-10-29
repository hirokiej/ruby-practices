# frozen_string_literal: true

class Option
  attr_reader :all_files, :reverse_files, :long_format

  def initialize
    @options = ARGV.getopts('alr')
    @all_files = @options['a']
    @reverse_files = @options['r']
    @long_format = @options['l']
  end
end
