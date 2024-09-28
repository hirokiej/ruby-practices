#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'frame'

class Game
  attr_accessor :frames

  def initialize(marks)
    @frames = []
    shots = remake_shots(marks)
    create_frames(shots)
  end

  def remake_shots(marks)
    shots = []

    marks.split(',').each do |s|
      if s == 'X'
        shots << 10
        shots << 0 if shots.size < 18
      else
        shots << s.to_i
      end
    end
    shots
  end

  def create_frames(shots)
    shots[0..17].each_slice(2) do |first_mark, second_mark|
      frame = Frame.new(first_mark, second_mark)
      @frames << frame
    end
    frame = Frame.new(shots[18], shots[19], shots[20])
    @frames << frame
  end

  def next_frame(index)
    @frames[index + 1]
  end

  def strike_bonus(index)
    return 10 + @frames[index].second_shot.score + @frames[index].third_shot.score if index == 9
    return 10 + next_frame(index).first_shot.score + next_frame(index).second_shot.score if index == 8

    if @frames[index].strike? && next_frame(index).strike?
      20 + next_frame(index + 1).first_shot.score
    else
      10 + next_frame(index).cal_for_frame
    end
  end

  def spare_bonus(index)
    if index == 9
      10 + @frames[index].third_shot.score
    else
      10 + next_frame(index).first_shot.score
    end
  end

  def cal_for_frames
    point = 0
    @frames.each_with_index do |frame, index|
      point += if frame.strike?
                 strike_bonus(index)
               elsif frame.spare?
                 spare_bonus(index)
               else
                 frame.cal_for_frame
               end
    end
    point
  end
end
