require 'telegram/bot'
require 'open-uri'
require 'vegan_bot/version'
require 'vegan_bot/edamam_api'

module VeganBot
  @options = {}

  def self.run(options)
    @options = options

    api = EdamamApi.new(@options[:edamam_id], @options[:edamam_key])

    Telegram::Bot::Client.run(@options[:telegram_token]) do |bot|
      bot.listen do |message|
        case message.text
        when '/start'
          bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}!")
        when %r(^\/recipe[ ]?(.*)$)
          query = message.text.match(%r(^\/recipe[ ]?(.*)$))[1] || ''
          recipe = api.search({q: query, health: 'vegan'})['hits'].sample['recipe']
          bot.api.send_message(chat_id: message.chat.id, text: "#{recipe['label']}\n#{recipe['url']}")
        when '/end'
          bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}!")
        else
          bot.api.send_message(chat_id: message.chat.id, text: "I don't understand you :(")
        end
      end
    end

  end
end
