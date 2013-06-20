class Purchase < Transaction
  # attr_accessible :title, :body
  # relationships
  has_many :line_items, dependent: :destroy

  accepts_nested_attributes_for :line_items

  after_save :calculate_amount
  after_save :update_customer_balance

  def calculate_amount
    self.amount = self.line_items.sum(&:item_total)
  end

  def update_customer_balance
    # new_balance = customer.total_purchases - customer.total_payments
    # customer.update_attribute(:balance, new_balance)
  end
end
