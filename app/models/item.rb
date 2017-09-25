class Item < ApplicationRecord
  belongs_to :user

  TIME_REMAINING_DAYS = 7.days

  def expires_at
    self.created_at + TIME_REMAINING_DAYS
  end
end
