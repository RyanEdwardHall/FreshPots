# sudo python -m SimpleHTTPServer 80
# require 'eventmachine'
require 'pi_piper'
require 'sonos'
require 'curb'
include PiPiper

after :pin => 17, :goes => :high do
	puts "went high"
end

PiPiper.wait
