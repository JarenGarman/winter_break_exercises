# frozen_string_literal: true

require_relative 'enigma'

message_file, filename = ARGV
message = File.read(message_file)
encrypted = Enigma.new.encrypt(message)
File.write(filename, encrypted[:encryption])
puts "Created '#{filename}' with the key #{encrypted[:key]} and date #{encrypted[:date]}"
