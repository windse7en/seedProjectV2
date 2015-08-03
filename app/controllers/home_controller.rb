class HomeController < ApplicationController
  attr_reader :vitals_mapping

  def initialize
    super
    @vitals_mapping = YAML.load_file 'lib/mapping_data/vitals.yaml'
  end 

  def index
    @mainTitle = "Welcome in Inspinia Rails Seed Project"
    @mainDesc = "It is an application skeleton for a typical Ruby on Rails web app. You can use it to quickly bootstrap your webapp projects and dev/prod environment."
    if user_signed_in?
      if (current_user.role != nil && !current_user.role.empty?)
        @result = get_all_patient_data
        @show_tour = false
        @patient_score = current_user.patient.patient_score.first
        gon.patient_score = @patient_score
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

  def live_chat
    respond_to do |format|
      format.js
    end 
  end

  def search_anything
    search_results = []
    s = User.search { fulltext params["top_search"] } 
    s.results.each do |r|
      search_results.push({label: 'Email:'+r.email, value: 'users'+r.id.to_s})
    end 
    return_json search_results
  end 

  def get_patient_vitals
    permitted = params.permit(:id)
    if !permitted.empty?
      begin 
        u = User.find(params[:id])
        p = Patient.find(u.patient_id)
        results = {}
        vitals_mapping.each do |i, v|
          next if check_attr_return instance: u, hash: results, attr_database: i, attr_custom: v
          next if check_attr_return instance: p, hash: results, attr_database: i, attr_custom: v
          raise "#{i} not in #{u.class}, #{p.class}"
        end 
      rescue Exception => e
        return return_json e.message
      end 
      return_json results
    else
      return_json "Error: Please set the id"
    end 
  end 

  private

  def check_attr_return(*args)
    checked_instance, attr, name, hash_result = args[0][:instance], args[0][:attr_database], args[0][:attr_custom], args[0][:hash]
    return false unless checked_instance.respond_to? attr
    hash_result[name] = checked_instance.public_send attr
    true
  end

  def return_json(result)
    respond_to do |format| 
      format.json {
        render json: result.to_json
      }
    end
  end 

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
