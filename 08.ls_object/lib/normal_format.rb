# frozen_string_literal: true

require_relative 'file'

module Ls
  class NormalFormat
    MAXIMUM_COLUMN = 3
    PATHNAME_MARGIN = 1

    def initialize(pathnames)
      @pathnames = pathnames
    end

    def lines
      total_pathnames = @pathnames.size
      (total_pathnames.to_f / MAXIMUM_COLUMN).ceil(0)
    end

    def sliced_pathnames
      pathnames = []
      @pathnames.each_slice(lines) { |n| pathnames << n }
      if pathnames.size >= MAXIMUM_COLUMN && @pathnames.size % MAXIMUM_COLUMN != 0
        (MAXIMUM_COLUMN - @pathnames.size % MAXIMUM_COLUMN).to_i.times { pathnames.last << nil }
      end
      pathnames
    end

    def sorted_pathnames
      sliced_pathnames.transpose
    end

    def output_format
      longest_pathname = @pathnames.max_by(&:size)
      sorted_pathnames.map do |row_pathnames|
        row_pathnames.map do |pathname|
          pathname = pathname ? ::File.basename(pathname) : ''
          pathname.ljust(longest_pathname.size + PATHNAME_MARGIN)
        end.join.rstrip
      end.join("\n")
    end
  end
end
