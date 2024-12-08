# frozen_string_literal: true

class Options
  def initialize(args)
    @options = args.getopts('alr')
  end

  def all_files?
    @options['a']
  end

  def reverse_files?
    @options['r']
  end

  def long_format?
    @options['l']
  end
end
