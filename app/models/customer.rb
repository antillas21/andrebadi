class Customer < ActiveRecord::Base

  include ActiveModel::ForbiddenAttributesProtection
  # attr_accessible :title, :body
  #
  attr_accessible :name, :phone, :email

  validates :name, presence: true
  delegate :purchases_total, to: :purchases

  belongs_to :user
  has_many :purchases do
    def total
      sum('purchase_total')
    end
  end

  has_many :payments

  def last_payment
    payments.last
  end

  def recent_payments
    payments.recent
  end

  def recent_purchases
    purchases.recent
  end

end
