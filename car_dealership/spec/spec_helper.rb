# frozen_string_literal: true

require 'simplecov'
SimpleCov.start
require 'pry'
require 'rspec'

require_relative '../lib/car'
require_relative '../lib/dealership'

RSpec.configure(&:disable_monkey_patching!)
