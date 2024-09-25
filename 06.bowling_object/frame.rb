#!/usr/bin/env ruby
# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_accessor :first_shot, :second_shot, :third_shot

  def initialize(first_mark, second_mark, third_mark = nil)
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
  end

  def cal_for_frame
    [@first_shot, @second_shot, @third_shot].map(&:score).sum
  end

  def strike?
    @first_shot.score == 10
  end

  def spare?
    !strike? && cal_for_frame == 10
  end
end
