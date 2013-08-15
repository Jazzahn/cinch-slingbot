require 'cinch'

bot = Cinch::Bot.new do
	configure do |c|
		c.server = "contego.ny.us.synirc.net"
		c.channels = ["#slingbot"]
		c.nick = "[SlingBot]"
		c.plugins.plugins = [PlayerList]
	end
end