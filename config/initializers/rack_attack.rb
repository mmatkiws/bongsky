Rack::Attack.blocklist_ip("115.78.92.182")
Rack::Attack.blocklist_ip("185.62.190.191")
Rack::Attack.blocklist_ip("81.248.43.189")
Rack::Attack.blocklist_ip("66.249.69.84")
Rack::Attack.blocklist_ip("88.99.63.132")
Rack::Attack.blocklist_ip("193.106.30.99")
Rack::Attack.blocklist_ip("171.120.101.31")
Rack::Attack.blocklist_ip("95.163.255.119")
Rack::Attack.blocklist_ip("183.131.85.103")
Rack::Attack.blocklist_ip("111.73.46.169")
Rack::Attack.blocklist_ip("179.190.123.172")
Rack::Attack.blocklist_ip("80.82.77.139")
Rack::Attack.blocklist_ip("66.249.69.80")
Rack::Attack.blocklist_ip("95.163.255.108")
Rack::Attack.blocklist_ip("123.24.205.50")
Rack::Attack.blocklist_ip("195.204.204.165")
Rack::Attack.blocklist_ip("66.249.65.116")
Rack::Attack.blocklist_ip("141.212.122.144")
Rack::Attack.blocklist_ip("34.201.223.224")
Rack::Attack.blocklist_ip("46.161.27.210")
Rack::Attack.blocklist_ip("66.249.66.77")

### Configure Cache ###

# If you don't want to use Rails.cache (Rack::Attack's default), then
# configure it here.
#
# Note: The store is only used for throttling (not blacklisting and
# whitelisting). It must implement .increment and .write like
# ActiveSupport::Cache::Store

Rack::Attack.cache.store = ActiveSupport::Cache::MemoryStore.new 


### Throttle Spammy Clients ###

# If any single client IP is making tons of requests, then they're
# probably malicious or a poorly-configured scraper. Either way, they
# don't deserve to hog all of the app server's CPU. Cut them off!
#
# Note: If you're serving assets through rack, those requests may be
# counted by rack-attack and this throttle may be activated too
# quickly. If so, enable the condition to exclude them from tracking.

# Throttle all requests by IP (60rpm)
#
# Key: "rack::attack:#{Time.now.to_i/:period}:req/ip:#{req.ip}"
Rack::Attack.throttle('req/ip', limit: 300, period: 5.minutes) do |req|
  req.ip # unless req.path.start_with?('/assets')
end