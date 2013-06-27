class PaymentSerializer < ActiveModel::Serializer
  attributes :id, :type, :amount, :created_at, :updated_at
  has_one :customer, serializer: CustomerListSerializer
end
