class LineItem < ActiveRecord::Base
  # attr_accessible :title, :body

  validates :name, :qty, :price, presence: true

  belongs_to :purchase

  before_save :calculate_total

  def calculate_total
    self.item_total = self.qty * self.price
  end
end
