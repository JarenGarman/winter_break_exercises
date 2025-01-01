# frozen_string_literal: true

require_relative 'enigma'

encrypted_file, filename, key, date = ARGV
decrypted = Enigma.new.decrypt(File.read(encrypted_file), key, date)
File.write(filename, decrypted[:decryption])
puts "Created '#{filename}' with the key #{decrypted[:key]} and date #{decrypted[:date]}"
