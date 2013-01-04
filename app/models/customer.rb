class Customer < ActiveRecord::Base
  # attr_accessible :title, :body
  #
  validates :name, :balance, presence: true

  belongs_to :user
  has_many :purchases
  has_many :payments
end
