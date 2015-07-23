module ClinicalScoreCalculabe
  
  # calculate all the clinical score
  def calculate_clin_score
    result={"clin_medication"=>0, "clin_labreport"=>0,"clin_sensor"=>0,"clin_biomarker"=>0}		

    # clin_medication logic ------- calculate the diff between prescription and pharmacy pick 
    re = execute_sql @sqls[:medication]
    if re.first.first <= 0
      result["clin_medication"] = 100
    end

    # clin_labreport logic
    re = execute_sql @sqls[:labreport]
    if re.first == nil
      test_height = 0
      test_blood = 0
      test_weight = 0
    else
      for i in re
        if i[1].include? "Height"
          v_height = [0, 60, 80, 100, 120, 999]
          m_height = [40, 80, 100, 80, 40]
          test_height = mapping_value_by_ranger(v_height, m_height, i[3].to_f)
        end
        if i[1].include? "Blood"
          t = i[3].split "/"
          v_highpressure = [0, 120, 140, 160, 180, 999]
          m_highpressure = [100, 80, 60, 40, 0]
          v_lowpressure = [0, 80, 90, 100, 110, 999]
          m_lowpressure = [100, 80, 60, 40, 0]
          test_blood = (mapping_value_by_ranger(v_highpressure, m_highpressure, t[0].to_f) + mapping_value_by_ranger(v_lowpressure, m_lowpressure, t[1].to_f) )/ 2
        end
        if i[1].include? "Weight"
          v_weight = [0, 100, 140, 160, 180, 200, 240, 300, 999]
          m_weight = [60, 90, 100, 90, 70, 60, 40, 20]
          test_weight = mapping_value_by_ranger(v_weight, m_weight, i[3].to_f)
        end
      end
    end
    result["clin_labreport"] = (test_height + test_blood + test_weight) / 3

    # clin_sensor missing
    # biomarker missing

    result
  end
end 
