class Customer < ActiveRecord::Base

  # attr_accessible :name, :phone, :email, :balance

  validates :name, presence: true

  belongs_to :user
  has_many :purchases, dependent: :destroy
  has_many :payments, dependent: :destroy
  has_many :transactions

  def total_purchases
    self.purchases.sum(:amount)
  end

  def total_payments
    self.payments.sum(:amount)
  end
end
