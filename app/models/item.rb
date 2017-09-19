class Item < ApplicationRecord
  belongs_to :user

  TIME_REMAINING_DAYS = 7

  def expires_at
    self.created_at + TIME_REMAINING_DAYS.days
  end
end
