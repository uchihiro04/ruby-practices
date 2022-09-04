# frozen_string_literal: true

require_relative 'shot'

class Frame
  attr_reader :index, :first_shot, :second_shot

  def initialize(index, first_mark, second_mark = nil, third_mark = nil)
    @index = index
    @first_shot = Shot.new(first_mark)
    @second_shot = Shot.new(second_mark)
    @third_shot = Shot.new(third_mark)
  end

  def self.generate_frames(scores)
    split_scores = []
    frames = []
    scores.split(',').each do |score|
      split_scores << score
      split_scores << '0' if split_scores.size < 18 && score == 'X'
    end
    split_scores.each_slice(2) { |score| frames.size == 10 ? frames[9] << score[-1] : frames << score }
    frames.map.with_index { |frame, index| Frame.new(index, frame[0], frame[1], frame[2]) }
  end

  def strike?
    @first_shot.score == 10
  end

  def spare?
    [@first_shot.score, @second_shot.score].sum == 10
  end

  def sum_shots
    [@first_shot.score, @second_shot.score, @third_shot.score].sum
  end

  def strike_bonus(frame, index)
    if next_frame(frame, index).strike? && index < 8
      next_frame(frame, index).first_shot.score + next_next_frame(frame, index).first_shot.score
    else
      next_frame(frame, index).first_shot.score + next_frame(frame, index).second_shot.score
    end
  end

  def spare_bonus(frames, index)
    next_frame(frames, index).first_shot.score
  end

  private

  def next_frame(frame, index)
    frame[index + 1]
  end

  def next_next_frame(frame, index)
    frame[index + 2]
  end
end
