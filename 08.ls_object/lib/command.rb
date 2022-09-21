# frozen_string_literal: true

require_relative 'normal_format'

module Ls
  class Command
    def initialize(option = nil)
      @option = option
    end

    def run_ls
      NormalFormat.new.show_files
    end
  end
end
