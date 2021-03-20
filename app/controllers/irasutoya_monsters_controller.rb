class IrasutoyaMonstersController < ApplicationController

  def index
    @monsters = IrasutoyaMonster.all
    json_response(@monsters)
  end

  private

  def irastuoya_monsters_params
    params.permit(:words)
  end

end
