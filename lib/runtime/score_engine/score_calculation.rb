Dir[File.dirname(__FILE__)+'/*.rb'].each { |f| require f }

class ScoreCalculation
  attr_reader :sqls, :user, :patient
  include ClinicalScoreCalculabe, BehaviorScoreCalculable, DemographyScoreCalculable, EnvironmentalScoreCalculable, SensorScoreCalculable

  def initialize(u_id)
    @user = User.find(u_id)
    @patient = user.patient
    p_id = user.patient_id
    @sqls = {
      medication: "select count(prescription_instance_id)-((select count(pharmacy_transaction_id) from pharmacy_transactions where prescription_id in(select prescription_id from prescriptions where patient_id=#{p_id}))) from prescriptions where patient_id = #{p_id};",
      labreport: "select a.patient_id,test_name, test_description,result,units from users a  join patient_tests b on a.patient_id=b.patient_id  join tests_old c on b.test_id = c.test_id where b.patient_id=#{p_id};"
    }
  end 

	def set_factors
		clin_factor = { "clin_medication"=>0.35, "clin_labreport"=>0.2, "clin_sensor"=>0.1, "clin_biomarker"=>0.35 }
		beha_factor = { "beha_nottakemedicine"=>0.6, "beha_smoking"=>0.1, "beha_alcohol"=>0.1, "beha_exercise"=>0.1, "beha_foodhabit"=>0.1}
		demo_factor = { "demo_finance"=>0.5, "demo_transportation"=>0.1, "demo_distancefromprovider"=>0.1, "demo_education"=>0.3 }
		envi_factor = { "envi_airquality"=>0.25, "envi_waterquality"=>0.25, "envi_weather"=>0.5}
		sens_factor = { "sens_bloodpressure"=>0.35, "sens_temperature"=>0.2, "sens_O2"=>0.1, "sens_bloodsugar"=>0.35 }
		whol_factor = {"clin_factor"=>0.4, "beha_factor"=>0.2, "demo_factor"=>0.2, "envi_factor"=>0.1, "sens_factor"=>0.1}
		factors = []
		factors.push clin_factor, beha_factor, demo_factor, envi_factor, sens_factor, whol_factor
		if test_sum_equal_one(factors) == false
			print "some factor is wrong"
		end
		return factors
	end

	def insert_whole_score
    result_final = []

    result_final.push(calculate_clin_score)
    result_final.push(calculate_beha_score)
    result_final.push(calculate_demo_score)
    result_final.push(calculate_envi_score)
    result_final.push(calculate_sens_score)

    factors = set_factors

    p = PatientScore.new
    p.patient_id = user.patient_id
    p.clin_medication = result_final[0]["clin_medication"] 
    p.clin_labreport = result_final[0]["clin_labreport"] 
    p.clin_sensor = result_final[0]["clin_sensor"] 
    p.clin_biomarker = result_final[0]["clin_biomarker"] 
    p.clin_overall = get_sum_from_result(factors[0], result_final[0])

    p.beha_nottakemedicine = result_final[1]["beha_nottakemedicine"]
    p.beha_smoking = result_final[1]["beha_smoking"]
    p.beha_alcohol = result_final[1]["beha_alcohol"]
    p.beha_exercise = result_final[1]["beha_exercise"]
    p.beha_foodhabit = result_final[1]["beha_foodhabit"]
    p.beha_overall = get_sum_from_result(factors[1], result_final[1])

    p.demo_finance = result_final[2]["demo_finance"]
    p.demo_transportation = result_final[2]["demo_transportation"]
    p.demo_distancefromprovider = result_final[2]["demo_distancefromprovider"]
    p.demo_education = result_final[2]["demo_education"]
    p.demo_overall = get_sum_from_result(factors[2], result_final[2])

    p.envi_airquality = result_final[3]["envi_airquality"]
    p.envi_waterquality = result_final[3]["envi_waterquality"]
    p.envi_weather = result_final[3]["envi_weather"]
    p.envi_overall = get_sum_from_result(factors[3], result_final[3])

    p.sens_bloodpressure = result_final[4]["sens_bloodpressure"]
    p.sens_temperature = result_final[4]["sens_temperature"]
    p.sens_O2 = result_final[4]["sens_O2"]
    p.sens_bloodsugar = result_final[4]["sens_bloodsugar"]
    p.sens_overall = get_sum_from_result(factors[4], result_final[4])

    p.overall_score =
      factors[5]["clin_factor"] * p.clin_overall +
      factors[5]["beha_factor"] * p.beha_overall +
      factors[5]["demo_factor"] * p.demo_overall +
      factors[5]["envi_factor"] * p.envi_overall +
      factors[5]["sens_factor"] * p.sens_overall

    p.updated_by = Time.now
    p.save
    result_final
	end

  private
    # calculate the sum from the result
    def get_sum_from_result (factor, result)
      sum = 0.0
      for i in result
        sum += factor[i[0]] * result[i[0]]
      end
      return sum
    end

    # test all the possibility combination is 1.
    def test_one_array (factor, one)
      sum = 0.0
      for i in factor
        sum += i[1]
      end
      if !((1.0-1).zero?)
        print sum
        print factor.to_s + "\n"
        return false
      end
      return true
    end

    def test_sum_equal_one (array_one)
      array_one.each do |i|
        if test_one_array(i,1) == false
          return false
        end
      end
      return true
    end

    # mappping from the ranger to the value, value_array is longer than 1 to the mapping_result
    def mapping_value_by_ranger (value_array = [], mapping_result = [], search)
      for i in 0..(value_array.length-2)
        if search >= value_array[i] && search <= value_array[i+1]
          return mapping_result[i]
        end
      end
      return -1
    end

    # mappping from the fixed map to the value
    # EX: v = {"good"=>100, "bad"=>0}
    def mapping_value_by_fixed_map (value_array = {}, search) 
      return value_array[search]
    end

    def execute_sql(sql)
      ActiveRecord::Base.connection.execute sql
    end 

end
