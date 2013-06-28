class Purchase < Transaction
  # attr_accessible :amount, :customer, :customer_id, :line_items_attributes, :line_items
  # relationships
  has_many :line_items, dependent: :destroy

  accepts_nested_attributes_for :line_items

  before_save :calculate_amount
  after_save :update_customer_balance

  def calculate_amount
    items_array = line_items.collect{|item| [item.qty, item.price]}
    total = items_array.inject(0){|sum, item| sum + (item[0] * item[1])}
    self.amount = total
  end

  def update_customer_balance
    new_balance = customer.total_purchases - customer.total_payments
    customer.update_attribute(:balance, new_balance)
  end
end
