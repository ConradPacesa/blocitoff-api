namespace :todo do
  desc "Delete items older than seven days"
  task delete_items: :environment do
    Item.where("created_at <= ?", Time.now - Item::TIME_REMAINING_DAYS).destroy_all
  end

end
