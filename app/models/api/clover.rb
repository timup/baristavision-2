module Api
  class Clover

    include HTTParty

    base_uri Api::Config.clover_url

    def initialize(access_token, merchant_id)
      @access_token = access_token
      @merchant_id = merchant_id
    end

    private

    def convert_to_mash data
      if data.is_a? Hash
        Hashie::Mash.new(data)
      elsif data.is_a Array
        data.map { |d| Hashie::Mash.new(d) }
      end
    end

  end
end