class Payment < ActiveRecord::Base
  # attr_accessible :title, :body

  validates :payment_date, :amount, presence: true

  belongs_to :customer
end
