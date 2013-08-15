require 'cinch'

bot = Cinch::Bot.new do
	configure do |c|
		c.server = "avarice.az.us.synirc.net"
		c.channels = ["#slingbot"]
		c.nick = "[SlingBot]"
	end
end