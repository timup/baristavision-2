module Api
  class Call

    attr_accessor :connect

    def initialize(authentication)
      @authentication = authentication
      @provider = authentication.provider
      @access_token = authentication.token
      @merchant_id = authentication.merchant_id

      if @provider == "clover"
        @connect = Api::Clover.new(@access_token, @merchant_id)
      elsif @provider == "square"
        @connect = Api::Square.new(@access_token)
      end
    end

    def line_items order_id
      @connect.line_items(order_id)
    end

    def orders
      @connect.orders
    end

    def order order_id
      @conndect.order(order_id)
    end

    def items
      @connect.items
    end

    def item item_id
      @connect.item(item_id)
    end

  end
end