#!/usr/bin/env ruby
# frozen_string_literal: true

score = ARGV[0]
scores = score.split(',')
shots = []
scores.each do |s|
  if s == 'X'
    shots << 10
    shots << 0
  else
    shots << s.to_i
  end
end

frames = []
shots.each_slice(2) do |s|
  frames << s
end

point = 0

frames.each_with_index do |frame, index|
  if frame == [10, 0]
    if index == 9 && frames[index + 1] && frames[index + 2]
      point += 10 + frames[index + 1].sum + frames[index + 2][0]
    else
      point += 10 + frames[index + 1].sum
      point += frames[index + 2][0] if frames[index + 1] == [10, 0]
    end
  elsif frame.sum == 10
    point += frame.sum + frames[index + 1][0]
  else
    point += frame.sum
  end
  break if index == 9
end

puts point
