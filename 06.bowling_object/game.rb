#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'frame'

class Game
  attr_accessor :frames

  LAST_FRAME = 9
  LAST_FRAME_FIRST_SHOT = LAST_FRAME * 2

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
        shots << 0 if shots.size < LAST_FRAME_FIRST_SHOT
      else
        shots << s.to_i
      end
    end
    shots
  end

  def create_frames(shots)
    shots[0..(LAST_FRAME_FIRST_SHOT - 1)].each_slice(2) do |first_mark, second_mark|
      frame = Frame.new(first_mark, second_mark)
      @frames << frame
    end
    frame = Frame.new(shots[LAST_FRAME_FIRST_SHOT], shots[LAST_FRAME_FIRST_SHOT + 1], shots[LAST_FRAME_FIRST_SHOT + 2])
    @frames << frame
  end

  def next_frame(index)
    @frames[index + 1]
  end

  def cal_total_score
    point = 0
    @frames.each_with_index do |frame, index|
      if index == LAST_FRAME
        point += frame.cal_frame_score
      else
        next_frame = next_frame(index)
        next_next_frame = next_frame(index + 1)

        point += if frame.strike?
                  frame.strike_bonus(index, next_frame, next_next_frame)
                elsif frame.spare?
                  frame.spare_bonus(next_frame)
                else
                  frame.cal_frame_score
                end
      end
    end
    point
  end
end
