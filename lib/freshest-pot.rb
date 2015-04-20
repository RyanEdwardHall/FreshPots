# require 'eventmachine'
require 'pi_piper'
require 'sonos'
include PiPiper

# Speaker setup
system = Sonos::System.new
speaker = system.speakers.first

after :pin => 23, :goes => :high do
  pp "Pin's hot!"
  # speaker.play 'http://asset.uri.com/lib/fresh-pots/grohl-1.mp3'
end

PiPiper.wait
