#!/usr/bin/env ruby

require 'optparse'
require 'date'

options = {}

OptionParser.new do |opt|
  opt.on('-y', '--year YEAR', Integer, 'Specify the number of year:y(default: current year)') do |year|
    options[:year] = year
  end
  opt.on('-m', '--month MONTH', Integer, 'Specify the number of month:m(default: current month)') do |month|
    options[:month] = month
  end
end.parse!

today = Date.today
year = options[:year] || today.year
month = options[:month] || today.month

first_day = Date.new(year, month, 1)
last_day = Date.new(year, month, -1)
whole_month = (first_day..last_day)

y_m = first_day.strftime('%B %Y')
day_name = Date::ABBR_DAYNAMES.map { |day| day[0, 2] }.join(' ')

puts y_m.center(20)
puts day_name
print '   ' * first_day.wday

whole_month.each do |date|
  if date.saturday?
    puts date.day.to_s.rjust(2)
  else
    print date.day.to_s.rjust(2)
    print ' '
  end
end
