class ViewingPartyController < ApplicationController
  def new
    @party = Party.new
    @friends = current_user.user_friendhips
  end

end
