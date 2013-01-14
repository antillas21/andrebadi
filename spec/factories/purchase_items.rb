# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :coat, class: PurchaseItem do
    name 'French Coat'
    qty 1
    item_total 1900
    purchase_id 1
  end

  factory :sweater, class: PurchaseItem do
    name 'Turtle Neck Sweater'
    qty 1
    item_total 900
    purchase_id 1
  end
end
