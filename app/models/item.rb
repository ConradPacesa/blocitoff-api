class Item < ApplicationRecord
  belongs_to :user
  attr_reader :test_field

  TIME_REMAINING_DAYS = 7

  def expires_at
    self.created_at + TIME_REMAINING_DAYS.days
  end
end
