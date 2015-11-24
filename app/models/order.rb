class Order < ActiveRecord::Base
  belongs_to :user
  has_many :line_items

  validates :order_id, uniqueness: true 

  def self.sync_with_api orders
  	for order in orders
  		create_from_api(order)
  		add_line_items(order)
  	end
  end

  def self.create_from_api order
  	self.find_or_create_by!(order_id: order['id'])
  end

  def self.add_line_items order
  	user = Order.find_by(order_id: order['id']).user
  end
end
