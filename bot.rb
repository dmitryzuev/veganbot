# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'rubygems'
require 'optparse'
require 'dotenv'
require 'vegan_bot'
require 'pp'

Dotenv.load

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: [bundle exec] ruby bot.rb [options]"

  opts.separator ""
  opts.separator "Specific options:"

  opts.on('-t', '--telegram-token TOKEN', 'Specify Telegram Bot API Token') do |t|
    options[:telegram_token] = t
  end

  opts.on('-i', '--edamam-id ID', 'Specify Edamam App ID') do |t|
    options[:edamam_id] = t
  end

  opts.on('-k', '--edamam-key ID', 'Specify Edamam App Key') do |t|
    options[:edamam_key] = t
  end

  # opts.on('-w', '--wger-token TOKEN', 'Specify wger API token') do |w|
  #   options[:wger_token] = w
  # end

  opts.separator ""
end.parse!

options[:telegram_token] ||= ENV.fetch('TELEGRAM_TOKEN')
options[:edamam_id]      ||= ENV.fetch('EDAMAM_ID')
options[:edamam_key]     ||= ENV.fetch('EDAMAM_KEY')

VeganBot.run(options)

# recipe = api.search({q: 'soup'})['hits'].sample['recipe']
#
# pp recipe['label']
# pp recipe['url']
# pp recipe['image']
# pp recipe['summary']

# Telegram::Bot::Client.run(options[:telegram_token]) do |bot|
#   bot.listen do |message|
#     case message.text
#     when '/start'
#       bot.api.send_message(chat_id: message.chat.id, text: "Hello, #{message.from.first_name}!")
#     when '/random'
#
#     when '/end'
#       bot.api.send_message(chat_id: message.chat.id, text: "Bye, #{message.from.first_name}!")
#     else
#       bot.api.send_message(chat_id: message.chat.id, text: "I don't understand you :(")
#     end
#   end
# end
