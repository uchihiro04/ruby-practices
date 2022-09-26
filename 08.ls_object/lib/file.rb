# frozen_string_literal: true

require 'etc'

module Ls
  class File
    FILE_TYPE = {
      'fifo' => 'p',
      'characterSpecial' => 'c',
      'directory' => 'd',
      'blockSpecial' => 'b',
      'file' => '-',
      'link' => 'l',
      'socket' => 's'
    }.freeze

    PERMISSION = {
      '0' => '---',
      '1' => '--x',
      '2' => '-w-',
      '3' => '-wx',
      '4' => 'r--',
      '5' => 'r-x',
      '6' => 'rw-',
      '7' => 'rwx'
    }.freeze

    attr_reader :filename
    
    def initialize(filename)
      @filename = filename
    end

    def blocks
      stat(@filename).blocks
    end

    def type
      FILE_TYPE[stat(@filename).ftype]
    end

    def stat(filename)
      ::File.lstat(filename)
    end

    def permission
      permission_number = stat(@filename).mode.to_s(8)[-3..-1]
      permission_number.gsub(/./, PERMISSION)
    end

    def hard_link
      stat(@filename).nlink.to_s
    end
    
    def username
      Etc.getpwuid(stat(@filename).uid).name
    end

    def groupname
      Etc.getgrgid(stat(@filename).gid).name
    end

    def file_size
      stat(@filename).size.to_s
    end

    def update_time
      stat(@filename).mtime.strftime('%_m %e %H:%M')
    end

  end
end
