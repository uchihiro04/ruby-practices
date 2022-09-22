# frozen_string_literal: true

require_relative 'normal_format'

module Ls
  class Command
    def initialize(option = nil)
      @option = option
    end

    def run_ls
      NormalFormat.new(filenames).show_files
    end

    def filenames
      a_option? ? Dir.glob('*', ::File::FNM_DOTMATCH) : Dir.glob('*')
    end

    def a_option?
      @option['a'] == true
    end
  end
end
