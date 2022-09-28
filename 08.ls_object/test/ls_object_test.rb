#!/usr/bin/env ruby
# frozen_string_literal: true

require 'minitest/autorun'
require_relative '../lib/ls_object'

class LsObjectTest < Minitest::Test
  def test_ls
    displayed_files = <<~FILENAME
      dummy_file1.txt dummy_file3.txt
      dummy_file2.txt sample
    FILENAME
    params = { 'a' => false, 'l' => false, 'r' => false }
    assert_output(displayed_files) { puts Ls::Command.new(params).run_ls }
  end

  def test_ls_option_a
    displayed_files = <<~FILENAME
      .               dummy_file1.txt sample
      ..              dummy_file2.txt
      .gitkeep        dummy_file3.txt
    FILENAME
    params = { 'a' => true, 'l' => false, 'r' => false }
    assert_output(displayed_files) { puts Ls::Command.new(params).run_ls }
  end

  def test_ls_option_r
    displayed_files = <<~FILENAME
      sample          dummy_file2.txt
      dummy_file3.txt dummy_file1.txt
    FILENAME
    params = { 'a' => false, 'l' => false, 'r' => true }
    assert_output(displayed_files) { puts Ls::Command.new(params).run_ls }
  end

  def test_ls_option_l
    params = { 'a' => false, 'l' => true, 'r' => false }
    assert_output(`ls -l`) { puts Ls::Command.new(params).run_ls }
  end

  def test_ls_multi_options_alr
    params = { 'a' => true, 'l' => true, 'r' => true }
    assert_output(`ls -alr`) { puts Ls::Command.new(params).run_ls }
  end

  def test_ls_multi_options_rla
    params = { 'a' => true, 'l' => true, 'r' => true }
    assert_output(`ls -rla`) { puts Ls::Command.new(params).run_ls }
  end
end
