# frozen_string_literal: true

require 'date'

# TLD
class Enigma # rubocop:disable Metrics/ClassLength
  def encrypt(message, key = Random.new.rand(99_999).to_s.rjust(5, '0'), date = Date.today.strftime('%d%m%y'))
    {
      encryption: get_output(message, key, date, 1),
      key: key,
      date: date
    }
  end

  def decrypt(message, key, date = Date.today.strftime('%d%m%y'))
    {
      decryption: get_output(message, key, date, -1),
      key: key,
      date: date
    }
  end

  def crack(message, date = Date.today.strftime('%d%m%y'))
    decrypt(message, get_key(message, date), date)
  end

  private

  @char_set = ('a'..'z').to_a << ' '
  @crack_ending = ' end'

  class << self
    attr_reader :char_set, :crack_ending
  end

  def char_set
    self.class.char_set
  end

  def crack_ending
    self.class.crack_ending
  end

  def get_output(message, key, date, sign_modifier)
    transform_chars(message.downcase.chars, get_shifts(key.chars, (date.to_i**2).digits), sign_modifier).join
  end

  def get_shifts(key_chars, offsets)
    shifts = []
    4.times do |i|
      shifts << ([key_chars[i], key_chars[i + 1]].join.to_i + offsets[3 - i])
    end
    shifts
  end

  def transform_chars(chars, shifts, sign_modifier)
    chars.each_with_index.map do |char, i|
      if char_set.find_index(char).nil?
        char
      else
        new_index = char_set.find_index(char) + (shifts.rotate(i % 4)[0] * sign_modifier)
        new_index -= 27 while new_index > 26
        new_index += 27 while new_index.negative?
        char_set[new_index]
      end
    end
  end

  def get_key(message, date) # rubocop:disable Metrics/AbcSize
    key_offsets = get_key_offset(message[-4..].chars.each_with_index.map do |char, i|
      get_shift(char, i)
    end, (date.to_i**2).digits)
    possible_keys = filter_keys(get_possible_keys(key_offsets))
    possible_keys = filter_keys(possible_keys) until possible_keys.map(&:length).all?(1) || possible_keys.any?([])
    possible_keys[0][0] + possible_keys[2][0] + possible_keys[3][0][1]
  end

  def get_shift(char, index)
    char_i = char_set.find_index(char)
    index_i = char_set.find_index(crack_ending[index])
    if char_i >= index_i
      char_i - index_i
    else
      27 - (index_i - char_i)
    end
  end

  def get_key_offset(shifts, date)
    shifts.each_with_index.map do |shift, i|
      offset = shift - date[3 - i]
      offset += 27 if offset.negative?
      offset
    end
  end

  def get_possible_keys(key_offsets)
    key_offsets.map do |key_offset|
      array = [key_offset]
      until key_offset + 27 > 99
        key_offset += 27
        array << key_offset
      end
      array.map { |possible_num| possible_num.to_s.rjust(2, '0') }
    end
  end

  def filter_keys(possible_keys)
    filtered_keys = []
    possible_keys.each_cons(2) do |first_keys, second_keys|
      filtered_keys << first_keys.select do |first_key|
        second_keys.map do |second_key|
          second_key[0]
        end.any?(first_key[1])
      end
    end
    filtered_keys << possible_keys.last
    filter_keys_backwards(filtered_keys)
  end

  def filter_keys_backwards(possible_keys)
    filtered_keys = []
    possible_keys.reverse.each_cons(2) do |first_keys, second_keys|
      filtered_keys << first_keys.select do |first_key|
        second_keys.map do |second_key|
          second_key[1]
        end.any?(first_key[0])
      end
    end
    filtered_keys << possible_keys.first
    filtered_keys.reverse
  end
end
