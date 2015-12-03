class SquareWorker
  include Sidekiq::Worker

  def perform data
  end
end