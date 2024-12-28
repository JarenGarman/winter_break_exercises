# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe Library do
  subject(:library) { described_class.new('Denver Public Library') }

  describe '#initialize' do
    it { is_expected.to be_instance_of described_class }
  end
end
