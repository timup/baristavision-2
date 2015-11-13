module Api
  class Call

    attr_accessor :connect

    def initialize(auth)
      @authentication = auth
      @provider = auth.provider
      @access_token = auth.token
      @merchant_id = auth.merchant_id

      if @provider == "clover"
        @connect = Api::Clover.new(@access_token, @merchant_id)
      elsif @provider == "square"
        @connect = Api::Square.new(@access_token)
      end
    end

    def items
      return @connect.items
    end

  end
end