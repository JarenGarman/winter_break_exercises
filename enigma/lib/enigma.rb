# frozen_string_literal: true

require 'date'

# TLD
class Enigma
  @@character_set = ('a'..'z').to_a << ' ' # rubocop:disable Style/ClassVars
  def encrypt(message, key, date = Date.today.strftime('%d%m%y'))
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

  private

  def get_output(message, key, date, sign_modifier)
    transform_chars(message.chars, get_shifts(key.chars, (date.to_i**2).digits.reverse), sign_modifier).join
  end

  def get_shifts(key_chars, offsets)
    shifts = []
    4.times do |i|
      shifts << ([key_chars[0 + i], key_chars[1 + i]].join.to_i + offsets[i - 4])
    end
    shifts
  end

  def transform_chars(chars, shifts, sign_modifier)
    output = []
    chars.each_with_index do |char, i|
      new_index = @@character_set.find_index(char) + (shifts.rotate(i % 4)[0] * sign_modifier)
      new_index -= 27 while new_index > 26
      new_index += 27 while new_index.negative?
      output << @@character_set[new_index]
    end
    output
  end
end
