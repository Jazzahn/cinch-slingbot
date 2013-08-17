require 'cinch'
require_relative 'plugins/stats'
require_relative 'plugins/ready'

bot = Cinch::Bot.new do
	configure do |c|
		c.server = "contego.ny.us.synirc.net"
		c.channels = ["#slingbot"]
		c.nick = "[SlingBot]"
		c.plugins.plugins = [PlayerList, PlayerStats]
	end
end

bot.start