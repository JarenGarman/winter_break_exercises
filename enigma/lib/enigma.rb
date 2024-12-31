# frozen_string_literal: true

require 'date'

# TLD
class Enigma
  def encrypt(message, key, date)
    keys = transform_key(key.digits.reverse)
    offsets = transform_date(date**2)
  end

  private

  def transform_key(key_digits)
    {
      a: [key_digits[0], key_digits[1]].join.to_i,
      b: [key_digits[1], key_digits[2]].join.to_i,
      c: [key_digits[2], key_digits[3]].join.to_i,
      d: [key_digits[3], key_digits[4]].join.to_i
    }
  end

  def transform_date(offsets)
    {
      a: offsets[-4],
      b: offsets[-3],
      c: offsets[-2],
      d: offsets[-1]
    }
  end
end
