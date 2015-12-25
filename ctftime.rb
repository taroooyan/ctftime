require 'open-uri'
require 'nokogiri'

# スクレイピング先のURL
url = 'https://ctftime.org/'

charset = nil
html = open(url) do |f|
  # 文字種別を取得
  charset = f.charset
  # htmlを読み込んで変数htmlに渡す
  f.read
end

# htmlをパース(解析)してオブジェクトを生成
doc = Nokogiri::HTML.parse(html, nil, charset)

p doc.title
i = 3
doc.xpath('//table/tr').each do |node|
  node.css('td').css('a').each do |event|
    if event['href'].include?("/event/") && i > 0
      puts node.inner_text.gsub("teams","teams ")
      i -= 1
    end
  end
end

