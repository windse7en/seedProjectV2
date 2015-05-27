class SessionsController < ApplicationController
  def create
    binding.pry
    p request.env['omniauth.auth']
    redirect_to '/'
  end 
end
