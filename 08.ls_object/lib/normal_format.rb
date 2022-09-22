# frozen_string_literal: true

require_relative 'file'

module Ls
  class NormalFormat
    MAXIMUM_COLUMN = 3
    FILENAME_MARGIN = 5

    def initialize(filenames)
      @filenames = filenames
    end

    def lines
      total_files = @filenames.size
      (total_files.to_f / MAXIMUM_COLUMN).ceil(0)
    end

    def sliced_filenames
      files = []
      @filenames.each_slice(lines) { |n| files << n }
      (MAXIMUM_COLUMN - @filenames.size % MAXIMUM_COLUMN).to_i.times { files.last << nil } if @filenames.size >= MAXIMUM_COLUMN && @filenames.size % MAXIMUM_COLUMN != 0
      files
    end

    def sorted_filenames
      sliced_filenames.transpose
    end

    def show_files
      longest_filename = @filenames.max_by { |filename| filename.size }
      sorted_filenames.each do |sorted_filename|
        sorted_filename.each do |s|
          break if s.nil?

          print s.ljust(longest_filename.size + FILENAME_MARGIN)
        end
        puts
      end
    end
  end
end
