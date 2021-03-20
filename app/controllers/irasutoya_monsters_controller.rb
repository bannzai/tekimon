class IrasutoyaMonstersController < ApplicationController

  def index
    @monsters = IrasutoyaMonster.all
    json_response(@monsters)
  end

  private

  def irastuoya_monsters_params
    params.permit(:words)
  end

  def json_response(object, status = :ok)
    render json: object, status: status
  end
end
