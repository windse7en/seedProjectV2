class HomeController < ApplicationController

  def index

    @mainTitle = "Welcome in Inspinia Rails Seed Project"
    @mainDesc = "It is an application skeleton for a typical Ruby on Rails web app. You can use it to quickly bootstrap your webapp projects and dev/prod environment."

    if user_signed_in?
      if !(current_user.role.empty?)
        render current_user.role+'_index'
      else
        render 'index'
      end 
    else
      redirect_to '/users/sign_in'
    end
  end

  def login
  end

  def minor
  end
end
