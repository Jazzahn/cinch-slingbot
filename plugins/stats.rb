require 'net/http'
require 'cinch'
require 'json'

class PlayerStats
  include Cinch::Plugin

  match /stats (.+)/

  def getstats (id)
    uri = URI.parse('http://127.0.0.1:3000/player/' + id + '.json')
    request = Net::HTTP::Get.new uri
    res = Net::HTTP.start(uri.hostname, uri.port) do |http|
      http.request(request)
    end

    stats = JSON.parse(res.body)

    if stats['matches'].to_i > 0
      mratio = ((stats['matcheswon'].to_f / stats['matches'].to_f) * 100).to_i
      gmatch = (stats['goals'].to_f / stats['matches'].to_f).round(1)
      amatch = (stats['assists'].to_f / stats['matches'].to_f).round(1)
    else
      mratio = 0
      gmatch = 0
      amatch = 0
    end

    if stats['rounds'].to_i > 0
      rratio = ((stats['roundswon'].to_f / stats['rounds'].to_f) * 100).to_i
    else
      rratio = 0
    end
    
    "#{stats['name']}: Match Win Ratio - #{mratio}%; Round Win Ratio - #{rratio}%; Goals/Match - #{gmatch}; Assists/Match - #{amatch}"
  end

  def execute (m, id)
    m.reply getstats(id)
  end
end