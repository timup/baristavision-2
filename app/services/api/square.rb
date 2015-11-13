module Api
  class Square

    include HTTParty

    base_uri Api::Config.square_url

    def initialize(access_token)
      @access_token = access_token
    end

    def query opts
      method   = opts[:method].to_s.downcase
      response = self.class.send(method, opts[:endpoint], opts[:params])
      data     = response.parsed_response

      if response.success?
        if [ TrueClass, FalseClass, Fixnum ].include?(data.class)
          data
        else
          puts response.request.inspect
          convert_to_mash(data)
        end
      else
        nil
      end
    end

    # square 'items'
    def items
      response = query({
        :endpoint => "/v1/me/items",
        :method => :GET,
        :params => {
          :headers => {
             "Authorization" => "Bearer #{@access_token}",
             "Accept" => "application/json"
          }
        }
        })
    end

    private

    def convert_to_mash data
      if data.is_a? Hash
        Hashie::Mash.new(data)
      elsif data.is_a? Array
        data.map { |d| Hashie::Mash.new(d) }
      end
    end

  end
end