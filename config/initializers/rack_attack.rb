Rack::Attack.blacklist('block 5.10.83.61') do |req|
  # Request are blocked if the return value is truthy
  '5.10.83.61' == req.ip
  '5.10.83.67' == req.ip
  '5.10.83.65' == req.ip
  '5.10.83.26' == req.ip
  '5.10.83.72' == req.ip
  '5.10.83.85' == req.ip
  '5.10.83.91' == req.ip
  '5.10.83.10' == req.ip
  '5.10.83.22' == req.ip
end


Rack::Attack.blacklisted_response = lambda do |env|
  # Using 503 because it may make attacker think that they have successfully
  # DOSed the site. Rack::Attack returns 403 for blacklists by default
  [ 503, {}, ['Blocked']]
end
