require 'cinch'

class PlayerList
  include Cinch::Plugin
  
  listen_to :leaving
  match "ready", method: :ready
  match "unready", method: :unready
  match "list", method: :list

  def initialize(*args)
    super

    @players = Set.new
  end

  def listen(m, user)
    @players.delete(m.user.nick)
  end
  
  def ready(m)
    @players.add(m.user.nick)
    if @players.length%2 == 0
      m.reply "#{m.user.nick} is READY to Sling some Rays!"
      m.reply "There are enough players for a #{@players.length / 2}v#{@players.length / 2}!"
    else
      m.reply "#{m.user.nick} is READY to Sling some Rays!"
    end
  end
  
  def unready(m)
    @players.delete(m.user.nick)
    m.reply "#{m.user.nick} is no longer ready to Sling some Rays."
  end
  
  def list(m)
    m.reply "Ready Players: " + @players.to_a.join(', ')
  end
end