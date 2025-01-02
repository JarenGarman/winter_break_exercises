# frozen_string_literal: true

require_relative 'enigma'

encrypted_file, filename, date = ARGV
decrypted = Enigma.new.crack(File.read(encrypted_file), date)
File.write(filename, decrypted[:decryption])
puts "Created '#{filename}' with the cracked key #{decrypted[:key]} and date #{decrypted[:date]}"
