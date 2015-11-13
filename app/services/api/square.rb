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
      @headers = response.headers
      data = response.parsed_response

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
      items = []
      more_results = true
      request_query = ''

      while more_results do 
        response = query({
          :endpoint => "/v1/me/items",
          :method => :GET,
          :params => {
            :headers => {
              "Authorization" => "Bearer #{@access_token}",
              "Accept" => "application/json"
            },
            :query => "#{request_query}"
          }
          })

        # Check whether pagination information is included in a response header, indicating more results
        if @headers.has_key?(:link)
          pagination_header = @headers[:link]

          if pagination_header.include? "rel='next'"
            # Extract the next batch URL from the header.
            #
            # Pagination headers have the following format:
            # <https://connect.squareup.com/v1/MERCHANT_ID/items?batch_token=BATCH_TOKEN>;rel='next'
            # This line extracts the URL from the angle brackets surrounding it.
            request_path = pagination_header.split('<')[1].split('>')[0]
            request_query = request_path.split('?')[1]
          else
            more_results = false
          end
        else
          more_results = false
        end
      end

      # Remove potential duplicate values from the list of items
      seen_item_ids = Set.new
      unique_items = []

      for item in response
        binding.pry
        if seen_item_ids.include? item['id']
          next
        end
        seen_item_ids.add(item['id'])
        unique_items << item
      end

      return unique_items
    end

    # square 'item'
    def item item_id
      response = query({
        :endpoint => "/v1/me/items/#{item_id}",
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