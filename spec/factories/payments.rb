# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :payment do
    payment_date { Time.now }
    amount 4000
    customer { create(:customer) }
  end
end
