# frozen_string_literal: true

require 'date'

# TLD
class Enigma
  @@character_set = ('a'..'z').to_a << ' ' # rubocop:disable Style/ClassVars
  def encrypt(message, key, date)
    {
      encryption: transform_chars(message.chars, get_shifts(key.chars, (date.to_i**2).digits.reverse)).join,
      key: key,
      date: date
    }
  end

  def decrypt(message, key, date)
    {
      decryption: transform_chars(message.chars, get_shifts(key.chars, (date.to_i**2).digits.reverse), -1).join,
      key: key,
      date: date
    }
  end

  private

  def get_shifts(key_chars, offsets) # rubocop:disable Metrics/AbcSize
    {
      0 => [key_chars[0], key_chars[1]].join.to_i + offsets[-4],
      1 => [key_chars[1], key_chars[2]].join.to_i + offsets[-3],
      2 => [key_chars[2], key_chars[3]].join.to_i + offsets[-2],
      3 => [key_chars[3], key_chars[4]].join.to_i + offsets[-1]
    }
  end

  def transform_chars(chars, shifts, encrypt = 1)
    output = []
    chars.length.times do |i|
      new_index = @@character_set.find_index(chars[i]) + (shifts[i % 4] * encrypt)
      new_index -= 27 while new_index > 26
      new_index += 27 while new_index.negative?
      output << @@character_set[new_index]
    end
    output
  end
end
