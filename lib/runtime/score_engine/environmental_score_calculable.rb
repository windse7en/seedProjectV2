module EnvironmentalScoreCalculable
  # calculate all the environment score
  def calculate_envi_score
    result={ "envi_airquality"=>0, "envi_waterquality"=>0, "envi_weather"=>0}		

    # envi_airquality logic ------- calculate the airquality 
    # the map for the water quality
    v_air = [0, 50, 100, 150, 200, 300, 500]
    m_air = [100, 80, 60, 40, 20, 0]
    result["envi_airquality"] = mapping_value_by_ranger(v_air, m_air, patient.air_quality.to_i)
    

    # envi_waterquality logic ------- calculate the waterquality 
    # the WQL index for water quality
    v_water = [0, 44, 65, 80, 95, 100]
    m_water = [0, 40, 60, 80, 100]
    result["envi_waterquality"] = mapping_value_by_ranger(v_water, m_water, patient.water_quality.to_i)

    # envi_weather logic ------- calculate the weather 
    v_weather = {"mild"=>100, "hot"=>60, "cold"=>40}
    result["envi_weather"] = mapping_value_by_fixed_map(v_weather, patient.weather)

    return result;
  end

end 
