module SensorScoreCalculable
  # calculate all the sensor score
  def calculate_sens_score
    result = { "sens_bloodpressure"=>0, "sens_temperature"=>0, "sens_O2"=>0, "sens_bloodsugar"=>0 }
    if patient.sensor_use == nil
    else
      case patient.sensor_use
      when "Fitbit"
        result = { "sens_bloodpressure"=>80, "sens_temperature"=>90, "sens_O2"=>100, "sens_bloodsugar"=>60 }
      else
      end
    end
    result
  end
end 

