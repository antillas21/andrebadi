class CustomerSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone, :balance, :created_at, :updated_at
  has_many :transactions, serializer: TransactionSerializer
end
