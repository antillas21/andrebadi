class Customer < ActiveRecord::Base
  # attr_accessible :title, :body
  #
  attr_accessible :name, :balance, :phone, :email

  validates :name, :balance, presence: true

  belongs_to :user
  has_many :purchases
  has_many :payments

  def calculate_balance
    # code to calculate balance
    purchases = self.purchases.pluck(:purchase_total).inject(0) { |sum, p| sum + p }
    payments = self.payments.pluck(:amount).inject(0) { |sum, p| sum + p }

    balance = purchases - payments

    self.update_attribute(:balance, balance)
  end
end
