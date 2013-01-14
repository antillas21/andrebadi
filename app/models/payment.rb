class Payment < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_accessible :payment_date, :amount, :customer_id

  validates :payment_date, :amount, presence: true

  belongs_to :customer

  after_save :update_customer_balance

  def update_customer_balance
    self.customer.calculate_balance
  end
end
