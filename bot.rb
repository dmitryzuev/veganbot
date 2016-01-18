require 'rubygems'
require 'optparse'
require 'dotenv'
require 'telegram/bot'

Dotenv.load


options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: [bundle exec] ruby bot.rb [options]"

  opts.separator ""
  opts.separator "Specific options:"

  opts.on('-t', '--telegram-token TOKEN', 'Specify Telegram Bot API Token') do |t|
    options[:telegram_token] = t
  end

  opts.on('-w', '--wger-token TOKEN', 'Specify wger API token') do |w|
    options[:wger_token] = w
  end

  opts.separator ""
end.parse!

options[:telegram_token] ||= ENV.fetch('TELEGRAM_TOKEN')
options[:wger_token]     ||= ENV.fetch('WGER_TOKEN')


Telegram::Bot::Client.run(options[:telegram_token]) do |bot|
  bot.listen do |message|
    case message.text
    when '/start'
      bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}!")
    when '/end'
      bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}!")
    else
      bot.api.send_message(chat_id: message.chat.id, text: "I don't understand you :(")
    end
  end
end
