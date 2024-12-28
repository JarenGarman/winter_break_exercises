# frozen_string_literal: true

require 'simplecov'
SimpleCov.start do
  enable_coverage :branch
end
require 'pry'
require 'rspec'

require_relative '../lib/car'
require_relative '../lib/dealership'

RSpec.configure(&:disable_monkey_patching!)
