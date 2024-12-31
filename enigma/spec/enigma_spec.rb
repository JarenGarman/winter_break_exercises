# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe 'Enigma' do
  subject(:enigma) { described_class.new }

  describe '#initialize' do
    it { is_expected.to be_instance_of described_class }
  end
end
