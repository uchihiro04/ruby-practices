require_relative 'file'

module Ls
  class LongFormat
    attr_reader :files
    def initialize(filenames)
      @files = filenames.map { |filename| Ls::File.new(filename) }
    end

    def total_blocks
      @files.sum { |file| file.blocks }
    end

    def max_hardlink_digits
      hard_links = @files.map { |file| file.hard_link }
      hard_links.max_by(&:size).size
    end

    def max_username_digits
      usernames = @files.map { |file| file.username }
      usernames.max_by(&:size).size
    end

    def max_groupname_digits
      groupnames = @files.map { |file| file.groupname }
      groupnames.max_by(&:size).size
    end

    def max_filesize_digits
      file_sizes = @files.map { |file| file.file_size }
      file_sizes.max_by(&:size).size
    end

    def format_row(file)
      [
        file.type,
        file.permission,
        "  #{file.hard_link.rjust(max_hardlink_digits)}",
        " #{file.username.ljust(max_username_digits)}",
        "  #{file.groupname.ljust(max_groupname_digits)}",
        "  #{file.file_size.rjust(max_filesize_digits)}",
        " #{file.update_time}",
        " #{file.filename}"
    ]
    end

    def output_format
      puts "total #{total_blocks}"
      @files.map do |file|
        format_row(file).join
      end.join("\n")
    end
    
  end
end
