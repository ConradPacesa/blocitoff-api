class ItemSerializer < ActiveModel::Serializer
  attributes :id, :name, :expires_at
  has_one :user

  def expires_at
    object.created_at + 7.days
  end
end
