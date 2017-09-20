class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :expires_at, :completed
  has_one :user

end
