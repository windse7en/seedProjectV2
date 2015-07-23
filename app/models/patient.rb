class Patient < ActiveRecord::Base
	has_one :user
  has_many :patient_score, foreign_key: "patient_id"
end
