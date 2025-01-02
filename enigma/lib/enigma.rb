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
    shifts = message[-4..].chars.each_with_index.map { |char, i| crack_get_shifts(char, i) }
    ordered_shifts = shifts.rotate(4 - (message.length % 4))
    ordered_key_offsets = get_key_offset(ordered_shifts, (date.to_i**2).digits)
    possible_keys = filter_keys(ordered_key_offsets)
    i = 0
    until possible_keys.map(&:length).all?(1) || possible_keys.any?([]) || i == 100
      possible_keys = filter_keys(possible_keys)
      i += 1
    end
    possible_keys[0].first + possible_keys[2].first + possible_keys[3].first[1]
  end

  def crack_get_shifts(char, index)
    char_i = char_set.find_index(char)
    index_i = char_set.find_index(crack_ending[index])
    get_possible_shifts(if char_i >= index_i
                          char_i - index_i
                        else
                          27 - (index_i - char_i)
                        end)
  end

  def get_possible_shifts(starting_shift)
    array = [starting_shift]
    until starting_shift + 27 > 108
      starting_shift += 27
      array << starting_shift
    end
    array
  end

  def get_key_offset(all_shifts, date)
    all_shifts.each_with_index.map do |shifts, i|
      shifts.map { |shift| shift - date[3 - i] }.reject(&:negative?).map { |shift| shift.to_s.rjust(2, '0') }
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
