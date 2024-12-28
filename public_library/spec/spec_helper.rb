# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  enable_coverage :branch
end
require 'pry'
require 'rspec'

require_relative '../lib/author'
require_relative '../lib/book'
require_relative '../lib/library'

RSpec.configure(&:disable_monkey_patching!)
