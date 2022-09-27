# frozen_string_literal: true

require_relative 'ls_format_factory'

module Ls
  class Command
    def initialize(option)
      @option = option
    end

    def run_ls
      ls_format = Ls::LsFormatFactory.create(@option)
      ls_format.output_format
    end

  end
end
