class Item < ActiveRecord::Base
  belongs_to :user
  validates :item_id, uniqueness: true 

  def self.sync_with_api items
  	active_item_ids = []

  	for item in items
  		create_from_api(item)
  		active_item_ids << item['id']
  	end

  	user = Item.find_by(item_id: active_item_ids.last).user
  	user_item_ids = user.items.map { |item| item.item_id }

    archive_item_ids = user_item_ids - active_item_ids
    for item_id in archive_item_ids
      item = Item.find_by(item_id: item_id)
      # create class method to toggle 
      # item.soft_delete
    end
  end

  def self.create_from_api item
    self.find_or_create_by!(item_id: item['id']) do |i|
      i.name = item['name']
    end
  end

end
