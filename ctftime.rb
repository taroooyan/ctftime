# URLにアクセスするためのライブラリの読み込み
require 'open-uri'
# Nokogiriライブラリの読み込み
require 'nokogiri'

# スクレイピング先のURL
url = 'https://ctftime.org/'

charset = nil
html = open(url) do |f|
  charset = f.charset # 文字種別を取得
  f.read # htmlを読み込んで変数htmlに渡す
end

# htmlをパース(解析)してオブジェクトを生成
doc = Nokogiri::HTML.parse(html, nil, charset)

# タイトルを表示
p doc.title

i = 3
doc.xpath('//table').each do |node|
  node.css('tr').css('td').css('a').each do |event|
    if event['href'].include?("/event/") && i > 0
      p event.inner_text
      i -= 1
    end
  end
end

