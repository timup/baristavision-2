Rails.application.config.middleware.use OmniAuth::Builder do
  provider :clover, ENV['CLOVER_APP_ID'], ENV['CLOVER_APP_SECRET']
  provider :square, ENV['SQUARE_APP_ID'], ENV['SQUARE_APP_SECRET'],
    {
        :connect_site  => 'https://connect.squareup.com'
    }
end
