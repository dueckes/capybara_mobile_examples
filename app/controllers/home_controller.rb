class HomeController < ApplicationController

  respond_to :html

  def index
    @user_agent = request.env['HTTP_USER_AGENT']
  end

end
