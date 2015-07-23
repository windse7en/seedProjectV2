module DemographyScoreCalculable
  # calculate all the demography score
  def calculate_demo_score
    result = { "demo_finance"=>0, "demo_transportation"=>0, "demo_distancefromprovider"=>0, "demo_education"=>0 }


    # demo_finance logic
    v_finance = {"UNDER $20,000"=>0,"$20,000 - $29,999"=>10,"$200,000 - $249,999"=>15,"$30,000 - $39,999"=>20,"$40,000 - $49,999"=>30,"$50,000 - $59,999"=>40, "$60,000 - $69,999"=>50,"$70,000 - $79,999"=>60, "$80,000 - $89,999"=>70, "$90,000 - $99,999"=>80,"$100,000 - $124,999"=>82,"$125,000 - $149,999"=>85,"$150,000 - $174,999"=>87, "$175,000 - $199,999"=>89, "$250,000 - $299,999"=>95,  "$300,000 - $399,999"=>100, "$400,000 - $499,999"=>100, "$500,000 Plus"=>100}
    result["demo_finance"] = mapping_value_by_fixed_map(v_finance, user.income)

    # demo_transportation logic
    result["demo_transportation"] = mapping_value_by_fixed_map(v_finance, user.income)		

    # demo_distancefromprovider logic		
    v_distancepharmacy = [0, 1, 5, 10, 20, 40, 60, 999]
    m_distancepharmacy = [100, 100, 80, 60, 40, 20, 0]
    d1 = mapping_value_by_ranger(v_distancepharmacy, m_distancepharmacy, patient.distance_from_pharmacy.to_i)
    v_distanceprovider = [0, 1, 5, 10, 20, 40, 60, 999]
    m_distanceprovider = [100, 100, 80, 60, 40, 20, 0]
    d2 = mapping_value_by_ranger(v_distanceprovider, m_distanceprovider, patient.distance_from_provider.to_i)
    result["demo_distancefromprovider"] = (d1 + d2) / 2

    # demo_education logic
    v_education = {"BA"=>60, "Masters"=>80, "PhD"=>100, "High School"=>40, "Associates"=>20}
    result["demo_education"] = mapping_value_by_fixed_map(v_education, user.education_levl)

    return result
  end

end
