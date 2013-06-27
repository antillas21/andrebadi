class TransactionSerializer < ActiveModel::Serializer
  attributes :id, :type, :amount, :created_at, :updated_at
end
