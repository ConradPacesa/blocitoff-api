class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :expires_at
  has_one :user

end
