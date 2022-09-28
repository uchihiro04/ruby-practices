# frozen_string_literal: true

require_relative 'file'

module Ls
  class LongFormat
    def initialize(pathnames)
      @paths = pathnames.map { |pathname| Ls::File.new(pathname) }
    end

    def output_format
      puts "total #{total_blocks}"
      @paths.map do |path|
        format_row(path).join
      end.join("\n")
    end

    private

    def total_blocks
      @paths.sum(&:blocks)
    end

    def max_hardlink_digits
      hard_links = @paths.map(&:hard_link)
      hard_links.max_by(&:size).size
    end

    def max_username_digits
      usernames = @paths.map(&:username)
      usernames.max_by(&:size).size
    end

    def max_groupname_digits
      groupnames = @paths.map(&:groupname)
      groupnames.max_by(&:size).size
    end

    def max_pathsize_digits
      pathsizes = @paths.map(&:pathsize)
      pathsizes.max_by(&:size).size
    end

    def format_row(path)
      [
        path.type,
        path.permission,
        "  #{path.hard_link.rjust(max_hardlink_digits)}",
        " #{path.username.ljust(max_username_digits)}",
        "  #{path.groupname.ljust(max_groupname_digits)}",
        "  #{path.pathsize.rjust(max_pathsize_digits)}",
        " #{path.update_time}",
        " #{path.pathname}"
      ]
    end
  end
end
