# frozen_string_literal: true

require_relative 'ls_format_factory'

module Ls
  class Command
    def initialize(option = nil)
      @option = option
    end

    def run_ls
      ls_format = LsFormatFactory.create(filenames, l_option?)
      ls_format.output_format
    end

    def filenames
      collected_filenames = a_option? ? Dir.glob('*', ::File::FNM_DOTMATCH) : Dir.glob('*')
      r_option? ? collected_filenames.reverse : collected_filenames
    end

    def a_option?
      @option['a'] == true
    end

    def r_option?
      @option['r'] == true
    end

    def l_option?
      @option['l'] == true
    end
  end
end
