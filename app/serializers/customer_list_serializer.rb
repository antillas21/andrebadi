class CustomerListSerializer < ActiveModel::Serializer
  attributes :id, :name, :email, :phone, :balance, :created_at, :updated_at
end
