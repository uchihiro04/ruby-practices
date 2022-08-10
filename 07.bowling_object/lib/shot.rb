#!/usr/bin/env ruby

class Shot
  attr_reader :mark

  def initialize(mark)
    @mark = mark
  end

  def show_shot_score
    mark == 'X' ?  10 : mark.to_i 
  end
end