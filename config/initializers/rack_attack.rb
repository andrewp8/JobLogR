# config/initializers/rack_attack.rb

class Rack::Attack
  # Allow all local traffic
  safelist('allow-localhost') do |req|
    '127.0.0.1' == req.ip || '::1' == req.ip
  end

  # Block suspicious requests for '.env' file
  blocklist('block-env-requests') do |req|
    req.path.include?('/.env')
  end
# Block requests to common WordPress paths
blocklist('block-wordpress-paths') do |req|
  # Patterns of WordPress-specific paths
  req.path.include?('/wp-') || req.path.include?('wp-admin') || req.path.include?('wp-includes')
end

  # Throttle requests to 5 requests per second per IP
  throttle('req/ip', limit: 5, period: 1.second) do |req|
    req.ip
  end

  # Track it using ActiveSupport::Notification
ActiveSupport::Notifications.subscribe('rack.attack') do |name, start, finish, request_id, req|
  puts "Rack::Attack: Blocklisted request #{req.path} from IP #{req.ip}"
end

end
