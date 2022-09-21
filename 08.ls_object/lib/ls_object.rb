#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'command'

Ls::Command.new(ARGV).run_ls if __FILE__ == $PROGRAM_NAME
