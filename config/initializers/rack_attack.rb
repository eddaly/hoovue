Rack::Attack.blacklist('block 5.10.83.61') do |req|
  # Request are blocked if the return value is truthy
  '5.10.83.61' == req.ip
  '5.10.83.67' == req.ip
  '5.10.83.65' == req.ip
end