class Purchase < ActiveRecord::Base
  # attr_accessible :title, :body
  #
  attr_accessible :purchase_date, :customer, :balance, :purchase_total
  attr_accessor :total

  validates :purchase_date, presence: true

  belongs_to :customer
  has_many :purchase_items do
    def total
      sum('item_total')
    end
  end

  before_save :calculate_total
  after_save :update_customer_balance

  def calculate_total
    prices = [ ]
    self.purchase_items.each { |item| prices << item.item_total }

    sum = prices.inject(0) { |result, price| result + price }

    self.purchase_total = sum
  end

  def total
    @total = purchase_items.total
  end

  def update_customer_balance
    self.customer.calculate_balance
  end
end
