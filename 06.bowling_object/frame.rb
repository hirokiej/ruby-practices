#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_accessor :first_shot, :second_shot, :third_shot

  BEFORE_LAST_FRAME = 8

  def initialize(first_mark, second_mark, third_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
  end

  def cal_frame_score
    [@first_shot, @second_shot, @third_shot].map(&:score).sum
  end

  def strike?
    @first_shot.score == 10
  end

  def spare?
    !strike? && cal_frame_score == 10
  end

  def strike_bonus(index, next_frame, next_next_frame)
    return 10 + next_frame.first_shot.score + next_frame.second_shot.score if index == BEFORE_LAST_FRAME

    if strike? && next_frame.strike?
      20 + next_next_frame.first_shot.score
    else
      10 + next_frame.cal_frame_score
    end
  end

  def spare_bonus(next_frame)
    10 + next_frame.first_shot.score
  end
end
