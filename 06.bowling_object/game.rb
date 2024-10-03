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

  def cal_for_frames
    point = 0
    @frames.each_with_index do |frame, index|
      if index == 9
        point += frame.cal_for_frame
      else
        next_frame = next_frame(index)
        next_next_frame = next_frame(index + 1)

        point += if frame.strike?
                  frame.strike_bonus(index, next_frame, next_next_frame)
                elsif frame.spare?
                  frame.spare_bonus(next_frame)
                else
                  frame.cal_for_frame
                end
      end
    end
    point
  end
end
