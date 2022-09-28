#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'command'

if __FILE__ == $PROGRAM_NAME
  params = ARGV.getopts('alr')
  puts Ls::Command.new(params).run_ls
end
