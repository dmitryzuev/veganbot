require 'telegram/bot'

require 'vegan_bot/version'
require 'vegan_bot/edamam_api'
# require 'vegan_bot/bot'

module VeganBot
  @options = {}

  def self.run(*args)
    @options = args
    puts 'ahaaha'
    puts @options
  end
end
