class LineItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :color, :size, :cost, :qty, :price, :item_total,
    :created_at, :updated_at
end
