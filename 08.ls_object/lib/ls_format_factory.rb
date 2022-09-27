require_relative 'normal_format'
require_relative 'long_format'

module Ls
  module LsFormatFactory
    def self.create(option)
      filenames = option['a'] ? Dir.glob('*', ::File::FNM_DOTMATCH) : Dir.glob('*')
      filenames = option['r'] ? filenames.reverse : filenames
      option['l'] ? Ls::LongFormat.new(filenames) : Ls::NormalFormat.new(filenames)
    end
  end
end
