# frozen_string_literal: true

require_relative 'normal_format'
require_relative 'long_format'

module Ls
  module LsFormatFactory
    def self.create(option)
      pathnames = option['a'] ? Dir.glob('*', ::File::FNM_DOTMATCH) : Dir.glob('*')
      pathnames = option['r'] ? pathnames.reverse : pathnames
      option['l'] ? Ls::LongFormat.new(pathnames) : Ls::NormalFormat.new(pathnames)
    end
  end
end
