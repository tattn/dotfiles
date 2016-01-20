#!/usr/bin/env ruby
begin
  require 'mechanize'
rescue LoadError
  puts 'This tool needs mechanize'
  puts 'please enter following:'
  puts 'gem install mechanize'
  exit 1
end

agent = Mechanize.new
agent.user_agent_alias = "Linux Firefox"
page = agent.get('http://searchranking.yahoo.co.jp/rt_burst_ranking/')
list = page / '//*[@id="main"]/div[1]/ul'
words = list.search('a').map {|word| word.text}
words.each_with_index do |word, i|
  puts "#{i+1}. #{word}"
end
