# require 'eventmachine'
require 'pi_piper'
require 'sonos'
require 'curb'
include PiPiper

# Speaker setup
# system = Sonos::System.new
# speaker = system.speakers.first

after :pin => 4, :goes => :high do
  pp "Pin is hot!"
  # speaker.play 'http://asset.uri.com/lib/fresh-pots/grohl-1.mp3'
  Curl.post('https://hooks.slack.com/services/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', {:payload => 'payload={"text": "/giphy FRESH POTS"}'})
end

PiPiper.wait
