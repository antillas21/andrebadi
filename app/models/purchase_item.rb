class PurchaseItem < ActiveRecord::Base
  # attr_accessible :title, :body

  validates :name, :qty, :item_total, presence: true

  belongs_to :purchase
end
