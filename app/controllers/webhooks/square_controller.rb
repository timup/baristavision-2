class Webhooks::SquareController < Webhooks::MainController

	# /webhooks/square
	# 	{
	#   	"merchant_id": "JGHJ0343",
	#   	"event_type": "PAYMENT_UPDATED",
	#   	"entity_id": "Jq74mCczmFXk1tC10GB"
	# 	}
	def receive
		request_body = request.body.read
		request_signature = request.env['HTTP_X_SQUARE_SIGNATURE']

		# SquareWorker.perform_async(options)
		head :ok
	end
end