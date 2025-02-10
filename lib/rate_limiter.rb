# Task:Implement in memory API rate limiter: maximum 1000 requests / 1 hour /1 IP address
# request {
#   ip: '127.0.0.1',
# }
class RateLimiter
  MAX_REQUESTS_PER_HOUR = 1000
  SECONDS_IN_HOUR = 3600

  attr_reader :queue

  def initialize
    @mutex = Mutex.new
    @queue = Hash.new { |hash, key| hash[key] = [] }
  end

  def valid?(request)
    ip = request[:ip]
    current_time = Time.now

    @mutex.synchronize do
      update_requests_queue(ip, current_time - SECONDS_IN_HOUR)

      if queue[ip].size < MAX_REQUESTS_PER_HOUR
        queue[ip] << current_time
        true
      else
        false
      end
    end
  end

  def update_requests_queue(ip, cutoff_time)
    queue[ip].reject! { |queued_time| queued_time < cutoff_time }
  end
end
