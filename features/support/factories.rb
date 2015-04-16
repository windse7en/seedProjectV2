require 'factory_girl'

FactoryGirl.define do
  factory :user do |f|
    f.email 'test@test.com'
    f.password 'password'
  end
end
