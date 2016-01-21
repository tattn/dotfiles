#!/usr/bin/env ruby

def ascii_art_text text
  begin
    require 'artii'
  rescue LoadError
    puts 'This tool needs [artii]:'
    puts 'gem install artii'
    exit 1
  end

  begin
    a = Artii::CLI.new text
    puts a.output
  rescue StandardError => e
    puts "Something has gone horribly wrong!"
    puts "Artii says: #{e.message}"
  end
end

def ascii_art_image img_url, width=80
  begin
    require 'asciiart'
  rescue LoadError
    puts 'This tool needs [ImageMagick, asciiart]:'
    puts 'brew install imagemagick, yum install ImageMagick, or apt-get install imagemagick'
    puts 'gem install asciiart'
    exit 1
  end
  a = AsciiArt.new img_url
  print a.to_ascii_art(width: width, color: true)
end

def ascii_art args
  case args[0]
  when 'text'
    ascii_art_text args[1]
  when 'image'
    if args[2]
      ascii_art_image args[1], args[2].to_i
    else
      ascii_art_image args[1]
    end
  else
    puts "unknown mode [#{args[0]}]"
  end
end

