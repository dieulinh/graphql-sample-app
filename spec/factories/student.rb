require 'rails_helper'
FactoryBot.define do
  factory :student do
    email { Faker::Internet.email }
    password { 'password' }
    password_confirmation { 'password' }
  end
end