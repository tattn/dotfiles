#!/usr/bin/env ruby
begin
  require 'mechanize'
rescue LoadError
  puts 'This tool needs [mechanize]:'
  puts 'gem install mechanize'
  exit 1
end

class String
  def full_length() count("^ -~｡-ﾟ") end
  def length_ja() length + full_length end
  def ljust_ja(width, padstr=' ') align_ja(:ljust, width, padstr) end
  def rjust_ja(width, padstr=' ') align_ja(:rjust, width, padstr) end
  def center_ja(width, padstr=' ') align_ja(:center, width, padstr) end

  def align_ja(method, width, padstr, dummy='A'*length_ja)
    if full_length == 0
      send(method, width, padstr)
    else
      dummy.succ!.empty? && break while padstr.include?(dummy)
      dummy.send(method, width, padstr).sub(dummy, self)
    end
  end
end

agent = Mechanize.new
agent.user_agent_alias = "Linux Firefox"
page = agent.get('http://searchranking.yahoo.co.jp/rt_burst_ranking/')
list = page / '//*[@id="main"]/div[1]/ul'
burst_words = list.search('a').map {|word| word.text}

page = agent.get('http://news.yahoo.co.jp/list')
list = page / '//*[@id="main"]/div[1]/div[1]/div[4]/ul'
news = list.search('a span[class=ttl]').map {|title| title.text}

width = 25
puts '-' * (width*2 + 5)
puts "#{'急上昇ワード'.center_ja(width)} | #{'ニュース'.center_ja(width)}"
puts '-' * (width*2 + 5)
burst_words.zip(news).each do |burst_word, news_title|
  puts "#{burst_word.center_ja width} | #{news_title.center_ja width}"
end
