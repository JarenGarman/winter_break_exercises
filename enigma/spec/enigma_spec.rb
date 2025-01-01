# frozen_string_literal: true

require_relative 'spec_helper'

RSpec.describe Enigma do
  subject(:enigma) { described_class.new }

  describe '#initialize' do
    it { is_expected.to be_instance_of described_class }
  end

  describe '#encrypt' do
    it 'can encrypt a message' do
      expect(enigma.encrypt('hello world', '02715', '040895')).to eq({
                                                                       encryption: 'keder ohulw',
                                                                       key: '02715',
                                                                       date: '040895'
                                                                     })
    end

    it 'can encrypt a message using todays date' do
      expect(enigma.encrypt('hello world', '02715')).not_to be_nil
    end

    it 'can encrypt a message using todays date and random key' do
      expect(enigma.encrypt('hello world')).not_to be_nil
    end
  end

  describe '#decrypt' do
    it 'can decrypt a message' do
      expect(enigma.decrypt('keder ohulw', '02715', '040895')).to eq({
                                                                       decryption: 'hello world',
                                                                       key: '02715',
                                                                       date: '040895'
                                                                     })
    end

    it 'can decrypt a message using todays date' do
      todays_crypt = enigma.encrypt('hello world', '02715')

      expect(enigma.decrypt(todays_crypt[:encryption], '02715')[:decryption]).to eq('hello world')
    end
  end
end
