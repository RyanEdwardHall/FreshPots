# sudo python -m SimpleHTTPServer 80
# require 'eventmachine'
require 'pi_piper'
require 'sonos'
require 'curb'
include PiPiper

brewing = true
# Initialize audio announcements
audio = []
audio_index = 0

Dir.foreach('/home/pi/coffee/FreshPots/public') do |file|
  next if file =='.' || file == '..'
  audio.push(file)
end
audio.sort!

# Speaker setup
system = Sonos::System.new
speaker = system.speakers.first

# after :pin => 4, :goes => :high do
#   speaker.play 'http://raspberrypi/' + audio[audio_index]
#   Curl.post('https://hooks.slack.com/services/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', {:payload => '{"text": "Something\'s brewing ..."}'})
#   audio_index = (audio_index + 1) % audio.length
#   brewing = true
# end

count = 0

after :pin => 17, :goes => :high do
  if count == 0
    count = 1
	current_volume = speaker.volume
	speaker.volume = 90
    Curl.post('https://hooks.slack.com/services/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', {:payload => '{"text": "/giphy fresh pots"}'})
	  speaker.play 'http://raspberrypi/' + audio[audio_index]
	  speaker.play
	  audio_index = (audio_index + 1) % audio.length
	sleep 16
	speaker.volume = current_volume
  end
end

PiPiper.wait
