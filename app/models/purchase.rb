class Purchase < ActiveRecord::Base
  # attr_accessible :title, :body
  #
  attr_accessible :purchase_date, :customer_id, :customer
  attr_accessor :total

  validates :purchase_date, presence: true

  belongs_to :customer
  has_many :purchase_items do
    def total
      sum('item_total')
    end
  end

  def total
    @total = purchase_items.total
  end

end
