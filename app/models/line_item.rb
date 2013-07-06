class LineItem < ActiveRecord::Base
  # attr_accessible :title, :body

  validates :name, :qty, :price, presence: true

  belongs_to :purchase

  before_save :calculate_sale_total
  before_save :calculate_cost_total

  def calculate_sale_total
    self.item_sale_total = self.qty * self.price
  end

  def calculate_cost_total
    self.item_cost_total = self.qty * self.cost
  end
end
