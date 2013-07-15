class Transaction < ActiveRecord::Base

  before_create :generate_uid

  # validations
  validates :amount, :customer_id, :uid, presence: true

  # realtionships
  belongs_to :customer

  default_scope { order('transactions.created_at ASC') }

  def generate_uid
    self.uid = (Time.now.to_f / 100).to_i
  end
end
