module BehaviorScoreCalculable
  # calculate all the behavior score
  def calculate_beha_score
    result = { "beha_nottakemedicine"=>0, "beha_smoking"=>0, "beha_alcohol"=>0, "beha_exercise"=>0, "beha_foodhabit"=>0}

    # beha_nottakemedicine logic ------- calculate the diff between prescription and pharmacy pick 
    re = execute_sql @sqls[:medication]
    if re.first.first <= 0
      result["beha_nottakemedicine"] = 100
    end

    # beha_smoking logic
    v_smoking = [0, 1, 5, 10, 20, 30, 999]
    m_smoking = [100, 80, 60, 40, 20, 0]
    result["beha_smoking"] = mapping_value_by_ranger(v_smoking, m_smoking, patient.tobacco_quantity_per_week.to_f)

    # beha_alcohol logic
    v_alcohol = [0, 1, 6, 10, 16, 999]
    m_alcohol = [100, 80, 60, 40, 0]
    result["beha_alcohol"] = mapping_value_by_ranger(v_alcohol, m_alcohol, patient.alcohol_beverages_weekly.to_f)

    # beha_exercise logic
    v_exercise = [0, 1, 6, 10, 20, 26, 999]
    m_exercise = [0, 20, 40, 60, 100, 80]
    result["beha_exercise"] = mapping_value_by_ranger(v_exercise, m_exercise, patient.hours_of_exercise_weekly.to_f)

    # beha_foodhabit logic
    v_sodium = [0, 1000, 1400, 1800, 2200, 9999]
    m_sodium = [20, 100, 80, 40, 0]
    sod = mapping_value_by_ranger(v_sodium, m_sodium, patient.weekly_sodium_intake.to_f)
    v_sugar = [0, 100, 200, 400, 600, 9999]
    m_sugar = [0, 60, 100, 40, 0]
    sugar = mapping_value_by_ranger(v_sugar, m_sugar, patient.daily_sugar_intake.to_f)
    v_fat = [0, 200, 300, 400, 500, 9999]
    m_fat = [0, 80, 100, 60, 0]
    fat = mapping_value_by_ranger(v_fat, m_fat, patient.daily_fat_intake.to_f)
    v_calories = [0, 1000, 1400, 1800, 2200, 2600, 9999]
    m_calories = [20, 80, 100, 80, 60, 0]
    calories = mapping_value_by_ranger(v_calories, m_calories, patient.daily_calories.to_f)
    result["beha_foodhabit"] = (sod + sugar + fat + calories) / 4

    return result
  end
end 
