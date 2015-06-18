require 'curb'

puts 'start'
Curl.post('https://hooks.slack.com/services/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', {:payload => 'payload={"text": "Something\'s brewing ..."}'})
puts 'done'

