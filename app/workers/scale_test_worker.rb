class ScaleTestWorker
  include Sidekiq::Worker

  def perform
    client = Twitter::REST::Client.new { |config| }

    while true
      sleep(10)
      begin
      client.update('Testing')
      rescue
      end
    end
    
  end
end
