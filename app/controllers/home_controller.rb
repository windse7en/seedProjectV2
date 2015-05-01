class HomeController < ApplicationController

  def index

    @mainTitle = "Welcome in Inspinia Rails Seed Project"
    @mainDesc = "It is an application skeleton for a typical Ruby on Rails web app. You can use it to quickly bootstrap your webapp projects and dev/prod environment."

    if user_signed_in?
      if (current_user.role != nil && !current_user.role.empty?)
        @result = get_all_patient_data
        render current_user.role+'_index', result: @result
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

  private

  def get_all_patient_data
    url_parsed = URI.parse("http://10.0.0.13:3003/get_all_patient_score/")
    begin
      response = Net::HTTP.get_response(url_parsed) {|http|
        http.read_timeout = 5
      }
    rescue 
      return {data: "nodata"}
    end
    return response.body.to_json
  end 
end
