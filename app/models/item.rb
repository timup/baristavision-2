class Item < ActiveRecord::Base
  belongs_to :user

  def test_method
  	puts self
  end


  def self.sync_with_api items
  	active_item_ids = []
  	for item in items
  		self.find_or_create_by!(item_id: item['id']) do |i| 
  			i.name = item['name']
  		end
  		active_item_ids << item['id']
  	end
  	user = Item.find_by(item_id: active_item_ids.last).user
  	user_item_ids = user.items.map { |item| item.item_id }
  end

  def self.create_from_api item
  end

end