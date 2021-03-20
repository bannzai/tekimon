require 'nokogiri'
require 'pry'

class IrasutoyaMonstersController < ApplicationController

  SEARCH_URL_BASE = 'https://www.irasutoya.com/search?q='
  def index
    words = irastuoya_monsters_params[:words]
    return json_response([]) if words.blank?
    words = words.split(',').sample(10)
    words = words.sample(10)
    monsters = IrasutoyaMonster.all
    words.each { |w| 
      doc_open(SEARCH_URL_BASE + word)
      binding.pry
    }
    binding.pry
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
