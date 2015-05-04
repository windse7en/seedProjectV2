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
    begin
      p "start"
      url = URI.parse("http://10.0.80.55:3003/get_all_patient_score/")
      p "parsed"
      http = Net::HTTP.new(url.host, url.port)
      http.read_timeout = 1
      http.open_timeout = 1
      response = http.start() {|htp| htp.get(url.path) }
      p "finished"
    rescue 
      return {data: "nodata"}
    end
    return response.body.to_json
  end 
end
