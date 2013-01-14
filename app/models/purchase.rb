class Purchase < ActiveRecord::Base
  # attr_accessible :title, :body
  #
  attr_accessible :purchase_date, :customer, :balance
  validates :purchase_date, presence: true

  belongs_to :customer
  has_many :purchase_items

  before_save :calculate_total
  after_save :update_customer_balance

  def calculate_total
    prices = [ ]
    self.purchase_items.each { |item| prices << item.item_total }

    sum = prices.inject(0) { |result, price| result + price }

    self.purchase_total = sum
  end

  def update_customer_balance
    self.customer.calculate_balance
  end
end
