class Order < ActiveRecord::Base
  belongs_to :user

  def self.sync_with_api orders
  	for order in orders
  		create_from_api(order)
  	end
  end

  def self.create_from_api order
  	self.find_or_create_by!(order_id: order['id'])
  end
end
