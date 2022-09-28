# frozen_string_literal: true

require 'etc'

module Ls
  class File
    PATH_TYPE = {
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

    attr_reader :pathname

    def initialize(pathname)
      @pathname = pathname
    end

    def blocks
      stat(@pathname).blocks
    end

    def type
      PATH_TYPE[stat(@pathname).ftype]
    end

    def permission
      permission_number = stat(@pathname).mode.to_s(8)[-3..]
      permission_number.gsub(/./, PERMISSION)
    end

    def hard_link
      stat(@pathname).nlink.to_s
    end

    def username
      Etc.getpwuid(stat(@pathname).uid).name
    end

    def groupname
      Etc.getgrgid(stat(@pathname).gid).name
    end

    def pathsize
      stat(@pathname).size.to_s
    end

    def update_time
      stat(@pathname).mtime.strftime('%_m %e %H:%M')
    end

    private

    def stat(pathname)
      ::File.lstat(pathname)
    end
  end
end
