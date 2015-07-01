# sudo python -m SimpleHTTPServer 80
# require 'eventmachine'
require 'pi_piper'
require 'sonos'
require 'curb'
include PiPiper

brewing = true
# Initialize audio announcements
audio = [
  { :file => '01_LadiesAndGentlemen.mp3',
    :text => 'Ladies and Gentlemen, a fresh pot of coffee has just been brewed, on the third floor.'
  },
  { :file => '03_HeadOver.mp3',
    :text => 'Head over to the third floor right now, a fresh pot of coffee has just been brewed.'
  },
  { :file => '04_NoNeedForStarbucks.mp3',
    :text => 'No need to take that trip to Starbucks, the third floor has you covered.'
  },
  { :file => '05_CaseOfMondays.mp3',
    :text => 'Have a case of "The Mondays?" Head on over to the third floor for a fresh pot of coffee.'
  },
  { :file => '02_AFreshPotOfCoffee.mp3',
    :text => 'A fresh pot of coffee has just been brewed, on the third floor.'
  },
  { :file => '06_CallColumbia.mp3',
    :text => 'Someone better call Columbia, because the third floor just out-did them in coffee.'
  },
  { :file => '07_CoworkerYouLike.mp3',
    :text => 'A fresh pot of coffee is ready on the third floor. Maybe that coworker you like will be there too. Seize the day my friend.'
  },
  { :file => '08_PourMyself.mp3',
    :text => 'This is the coffee machine on the third floor. I\'m not going to pour myself, you know.'
  },
  { :file => '09_LeaveYourDesk.mp3',
    :text => 'A fresh pot of coffee is now available on the third floor. Now you have a legitimate reason to leave your desk. You\'re welcome.'
  },
  { :file => '10_SweetEnoughAlready.mp3',
    :text => 'A pot of coffee is now available on the third floor. But you don\'t need sugar, you\'re sweet enough already.'
  },
  { :file => '11_mmmmm.mp3',
    :text => 'Third floor. Coffee. Mmmmmm.'
  },
  { :file => '12_AlexanderTheGreat.mp3',
    :text => 'In the words of Alexander the Great, "I\'m going to the third floor to get some coffee."'
  },
  { :file => '13_FindOutForYourself.mp3',
    :text => 'They say "coffee makes you a better thinker." They say "the third floor has coffee." I don\'t know if these are true, I\'m simply giving you this option to find out for yourself.'
  }]

audio_index = (rand * audio.length).to_i

# Speaker setup
system = Sonos::System.new
speaker = system.speakers.first

last_brewed = 0

after :pin => 4, :goes => :high do
  return if (Time.now.getutc.to_i - last_brewed) < 30
  puts 'Brewed'

  audio_index = (audio_index + 1) % audio.length

  Curl.post(
    'https://hooks.slack.com/services/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', 
    {:payload => '{"text": audio[audio_index][:text]}'})

  if !speaker.nil?
    current_volume = speaker.volume
    speaker.volume = 90

    speaker.play 'http://172.16.0.218/' + audio[audio_index][:file]
    speaker.play

    sleep 16
    speaker.volume = current_volume
  end

  last_brewed = Time.now.getutc.to_i
end

PiPiper.wait
