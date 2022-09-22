# frozen_string_literal: true

module Ls
  class File
    attr_reader :filename

    def initialize(filename)
      @filename = filename
    end
  end
end
