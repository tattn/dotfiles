#!/usr/bin/env ruby
begin
  require 'artii'
rescue LoadError
  puts 'This tool needs [artii]:'
  puts 'gem install artii'
  exit 1
end

def ascii_art args
  case args[0]
  when 'text'
    begin
      a = Artii::CLI.new args[1]
      puts a.output
    rescue StandardError => e
      puts "Something has gone horribly wrong!"
      puts "Artii says: #{e.message}"
    end
  else
    puts "unknown mode [#{args[0]}]"
  end
end

