require "date"

#今日の年月日
date = Date.today
#今年と今月
year = date.year
month = date.month

#月初めから月末
first_day = Date.new(year, month, 1)
last_day = Date.new(year, month, -1)
#1ヶ月分の日にち
whole_month = (first_day..last_day).to_a

#年と月
y_m = [Date::MONTHNAMES[month],year].join(" ")
#曜日
weekd = Date::ABBR_DAYNAMES.join(" ")
#年月と曜日の出力
puts y_m.to_s.center(26)
puts weekd

#1日の位置調整
print "    " *  first_day.wday

#1ヶ月間の日にち
whole_month.each do |single_day|
  if single_day.wday == 6
    print " "
    puts single_day.day.to_s.rjust(2)
  else
    print " "
    print single_day.day.to_s.rjust(2)
    print " "
  end
end

