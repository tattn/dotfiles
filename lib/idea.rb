#!/usr/bin/env ruby

#
# Osborn's Checklist
#
# Usage:
#   idea.rb <keyword>
#   or
#   idea.rb wikipedia
#   idea.rb niconico
#   idea.rb randomsearch
#   idea.rb

require 'open-uri'

def makelist
  list = []
  # 転用：他に使い道はないか？
  # Put to other uses?
  list[0] = %w{
  の未来はどうなっているか
  を他の分野で使ったら
  に新しい用途はないか
  の未来はどうなっているか
  をチューニングしたら
  を別の目的で使ったら
  を別の時間に使ったら
  を別の場所で使ったら
  を物語にしたら
  の王道を外れたら
  を自動化したら
  の仮説を否定したら
  に他の利用法はないか
  をゲームにしたら
  をあなたが使ったら
  のタブーを無くしたら
  }

  # 応用：他からアイデアを借りられないか？
  # Adapt?
  list[1] = %w{
  に似た商品の真似をしたら
  に似た人の真似をしたら
  に似たモノの真似をしたら
  は昔どう使われていたか
  を上司ならどうするか
  を「尊敬するあの人」ならどうするか
  を同業者はどうしているか
  をライバルならどうするか
  を共有したら
  を他分野はどうしているか
  を同業者はどうしているか
  }

  # 変更：変えてみたらどうか？
  # Modify?
  list[2] = %w{
  の動きを変えたら
  の見た目を変えたら
  の利用者を変えたら
  を優しくしたら
  の目的を変えたら
  をカスタマイズしたら
  の主語を変えたら
  の戦場を変えたら
  の常識を変えたら
  の場所を変えたら
  の売り場を変えたら
  のイメージを変えたら
  の先入観を変えたら
  の軸をズラしたら
  の香りを変えたら
  のニーズを変えたら
  の音を変えたら
  }

  # 拡大：大きくしてみたらどうか？
  # Magnify?
  list[3] = %w{
  を大きくしたら
  を重くしたら
  を長くしたら
  を高くしたら
  の範囲を広くしたら
  の成分を増やしたら
  の目的を広げたら
  のメリットを広げたら
  の機能を増やしたら
  の強度を上げたら
  の地域を広げたら
  の価値を広げたら
  の市場を広げたら
  の濃度を上げたら
  の意味合いを広げたら
  }

  # 縮小：小さくしてみたらどうか？
  # Minify?
  list[4] = %w{
  を小さくしたら
  を短くしたら
  の時間を短くしたら
  の範囲を狭くしたら
  のターゲットを狭めたら
  の場所を狭めたら
  のムダを無くせないか
  の強度を下げたら
  の材料を減らしたら
  の成分を減らしたら
  の目的を狭めたら
  の回数を減らしたら
  の機能を減らしたら
  の市場を絞ったら
  を無料にしたら
  }

  # 代用：他のもので代用できないか？
  # Substitute?
  list[5] = %w{
  を他の人で代用したら
  を他の材料で代用したら
  を持ち歩けないか
  をプライベートで使えないか
  のリスクを代えたら
  を代替品にしたら
  を偽物にしたら
  を他の製法で代用したら
  を家で使えないか
  を会社で使えないか
  をネットで使えないか
  が注目されたら
  を他の方法で代用したら
  を通勤中に使えないか
  を仕事中に使えないか
  をネットで使えないか
  }

  # 置換：入れ替えてみたらどうか？
  # Rearrange?
  list[6] = %w{
  の配置を入替えたら
  のパターンを入替えたら
  のレイアウトを入替えたら
  のパーツを取替えたら
  をトレードしたら
  をこっそり入替えたら
  の目的を入替えたら
  を誰かと交換したら
  の人を入替えたら
  の場所を入替えたら
  }

  # 逆転：逆にしてみたらどうか？
  # Reverse?
  list[7] = %w{
  のプラスマイナスを逆にしたら
  を客観的に考えたら
  のメリットを否定したら
  のデメリットを肯定したら
  の常識を否定したら
  を捨てたら
  の弱みを強みにしたら
  の不安を無くしたら
  と○○の役割を変えたら
  と○○の立場を変えたら
  の上下を逆にしたら
  の左右を逆にしたら
  の買い手になって考えたら
  をシンプルにしたら
  を逆から見たら
  を不便を便利にしたら
  }

  # 結合：組み合わせてみたらどうか？
  # Combine?
  list[8] = %w{
  のライバルと手を組んだら
  に似たものと手を組んだら
  をまとめたら
  と利用シーンを組合せたら
  と真逆のモノを組合せたら
  がコンビを組んだら
  にギャップをつくったら
  が集まったら
  の今と過去を組み合わせたら
  に体験を組合せたら
  に食べ物を組合せたら
  に飲み物を組合せたら
  に睡眠を組合せたら
  に運動を組合せたら
  }

  list
end

def random_keyword_wikipedia
  url = 'https://ja.wikipedia.org/wiki/Special:Randompage'
  html = open(url).read
  if html =~ /<title>(.*)<\/title>/
    return $1[0, $1.length - 12]
  end
end

def random_keyword_niconico
  url = 'http://dic.nicovideo.jp/random/a'
  html = open(url).read
  if html =~ /<h1 title.*>(.*)<\/h1>/
    return $1[6, $1.length]
  end
end

def random_keyword_randomsearch
  url = 'http://butaman.ymk-spark.or.jp/soft/testtech/randomsearch/WebApi.aspx?results=1'
  html = open(url, 'r:utf-8').read
  if html =~ /<Result>(.*)<\/Result>/
    return $1
  end
end

def osborn keyword=nil
  list = makelist

  case keyword
  when 'wikipedia'
    keyword = random_keyword_wikipedia
  when 'niconico'
    keyword = random_keyword_niconico
  when 'randomsearch'
    keyword = random_keyword_randomsearch
  when nil
    services = ['wikipedia', 'niconico', 'randomsearch']
    keyword = send "random_keyword_#{services.sample}"
  end

  list.each do |words|
    puts "・#{keyword}#{words.sample}"
  end
end

if $0 == __FILE__
  osborn ARGV[0]
end
