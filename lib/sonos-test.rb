require 'sonos'

puts 'start'

audio = []
audio_index = 0
Dir.foreach('/home/pi/coffee/FreshPots/public') do |file|
  next if file =='.' || file == '..'
  audio.push(file)
end
audio.sort!

puts audio[audio_index]

# Speaker setup
system = Sonos::System.new
speaker = system.speakers.first
speaker.play 'http://172.16.0.218/' + audio[audio_index]
# speaker.play
puts 'done'
