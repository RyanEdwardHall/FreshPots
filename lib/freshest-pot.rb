# require 'eventmachine'
require 'pi_piper'
require 'sonos'
require 'curb'
include PiPiper

brewing = false
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

after :pin => 4, :goes => :low do
  if brewing
    brewing = false
    speaker.play 'http://127.0.0.1/' + audio[audio_index]
    Curl.post('https://hooks.slack.com/services/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', {:payload => '{"text": "FRESH POTS!"}'})
    audio_index = (audio_index + 1) % audio.length
  end
end

PiPiper.wait
