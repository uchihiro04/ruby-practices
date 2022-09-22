#!/usr/bin/env ruby
# frozen_string_literal: true

require 'optparse'
require_relative 'command'

params = ARGV.getopts('alr')
Ls::Command.new(params).run_ls
