#!/usr/bin/env ruby

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
  if frame == [10, 0] && index < 10 # 9フレームまでのストライクボーナス
    point += 10 + frames[index + 1].sum
    point += frames[index + 2][0] if frames[index + 1] == [10, 0]
  elsif frame.sum == 10 && index < 10 # 9フレームまでのスペアボーナス
    point += frame.sum + frames[index + 1][0]
  else
    point += frame.sum
  end
  break if index == 9
end

puts point
