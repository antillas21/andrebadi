class Payment < ActiveRecord::Base
  # attr_accessible :title, :body

  attr_accessible :payment_date, :amount, :customer_id

  validates :payment_date, :amount, presence: true

  belongs_to :customer

end
