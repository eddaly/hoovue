if defined?(MailSafe::Config)
  MailSafe::Config.internal_address_definition = /.*@my-domain\.com/i
  MailSafe::Config.replacement_address = 'nick@epcess.co.uk'
end