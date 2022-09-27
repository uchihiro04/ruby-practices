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
      if files.size >= MAXIMUM_COLUMN && @filenames.size % MAXIMUM_COLUMN != 0
        (MAXIMUM_COLUMN - @filenames.size % MAXIMUM_COLUMN).to_i.times { files.last << nil }
      end
      files
    end

    def sorted_filenames
      sliced_filenames.transpose
    end

    def output_format
      longest_filename = @filenames.max_by(&:size)
      sorted_filenames.map do |row_filenames|
        row_filenames.map do |filename|
          filename = filename ? ::File.basename(filename) : ''
          filename.ljust(longest_filename.size + FILENAME_MARGIN)
        end.join.rstrip
      end.join("\n")
    end

  end
end
