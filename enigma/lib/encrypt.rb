# frozen_string_literal: true

require_relative 'enigma'

message_file, filename = ARGV
encrypted = Enigma.new.encrypt(File.read(message_file))
File.write(filename, encrypted[:encryption])
puts "Created '#{filename}' with the key #{encrypted[:key]} and date #{encrypted[:date]}"
