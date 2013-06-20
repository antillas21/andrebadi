# Read about factories at https://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :purchase do
    customer { create(:customer) }

    factory :purchase_and_items do
      ignore do
        items_count 2
      end

      before(:create) do |purchase, evaluator|
        create_list(:coat, evaluator.items_count, purchase: purchase)
        # purchase.amount = purchase.line_items.sum(:item_total)
      end
    end
  end
end
