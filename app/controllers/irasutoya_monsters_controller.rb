require 'nokogiri'
require 'open-uri'


class IrasutoyaMonstersController < ApplicationController
  CHARSET = 'utf-8'
  SEARCH_URL_BASE = 'https://www.irasutoya.com/search?q='
  def index
    words = irastuoya_monsters_params[:words]
    puts "words: #{words}"
    return json_response([]) if words.blank?
    splited = words.split(',').sample(10)
    selected_words = splited.sample(10)
    puts "selected_words: #{selected_words}"
    targets = []
    selected_words.each { |word| 
      doc = doc_open(SEARCH_URL_BASE + word)
      links = doc.xpath('//*[@id="post"]/div[1]/a')
      next if links.blank?
      links.each { |link|
        link_value = link.attributes&.[]("href").value
        next if link_value.blank?
        target = Struct.new("Target", :word, :link_url).new(word, link_value)
        targets.push(target)
      }
    }
    monsters = IrasutoyaMonster.where(page_url: targets.map { |e| e.link_url })
    json_response(monsters)
  end

  private

  def irastuoya_monsters_params
    params.permit(:words)
  end

  def json_response(object, status = :ok)
    render json: object, status: status
  end

  def doc_open(url)
    Nokogiri::HTML.parse(URI.open(URI.escape(url.to_s).to_s), nil, CHARSET)
  end
end
