class LineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item

  validates :line_item_id, uniqueness: true 

  def self.sync_with_api line_items
  	for line_item in line_items
  		create_from_api(line_item)
  	end
  end

  def self.create_from_api line_item
  	# self.find_or_create_by!(line_item_id:  )
  end
end
