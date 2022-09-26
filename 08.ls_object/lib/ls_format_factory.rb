require_relative 'normal_format'
require_relative 'long_format'

module LsFormatFactory
  def self.create(filenames, l_option)
    l_option ? Ls::LongFormat.new(filenames) : Ls::NormalFormat.new(filenames)
  end
end
