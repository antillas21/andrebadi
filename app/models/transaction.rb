class Transaction < ActiveRecord::Base
  # attr_accessible :title, :body

  # validations
  validates :amount, :customer_id, presence: true

  # realtionships
  belongs_to :customer

  default_scope order: 'created_at DESC'
end
