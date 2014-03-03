Rack::Attack.blacklist('block 5.10.83.91') do |req|
  # Request are blocked if the return value is truthy
  '5.10.83.91' == req.ip
end

Rack::Attack.blacklist('block 5.10.83.22') do |req|
  # Request are blocked if the return value is truthy
  '5.10.83.22' == req.ip
end


Rack::Attack.blacklisted_response = lambda do |env|
  # Using 503 because it may make attacker think that they have successfully
  # DOSed the site. Rack::Attack returns 403 for blacklists by default
  [ 503, {}, ['Blocked']]
end
