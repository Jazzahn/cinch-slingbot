require 'cinch'

class PlayerList
	include Cinch::Plugin
	
	listen_to :leaving
	match "ready", method: :ready
	match "unready", method: :unready
	match "list", method: :list

	def initialize(*args)
		super

		players = []
	end

	def listen(m, user)
		players.delete(m.user.nick)
		m.reply "#{m.user.nick} has quit test"
	end
	
	def ready(m)
		players << m.user.nick
		m.reply "#{m.user.nick} is READY to Sling some Rays!"
	end
	
	def unready(m)
		players.delete(m.user.nick)
		m.reply "#{m.user.nick} is no longer ready to Sling some Rays."
	end
	
	def list(m)
		m.reply players
	end
end

bot = Cinch::Bot.new do
	configure do |c|
		c.server = "contego.ny.us.synirc.net"
		c.channels = ["#slingbot"]
		c.nick = "[Slingbot]"
		c.plugins.plugins = [PlayerList]
	end
end