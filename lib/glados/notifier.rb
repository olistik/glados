module Glados
  class Notifier
    def initialize
      @bot = Telegram::Bot.new(bot_token: ENV["TELEGRAM_BOT_TOKEN"])
      @chat_id = ENV["TELEGRAM_CHAT_ID"]
    end

    def notify(message)
      @bot.send_message(chat_id: @chat_id, text: message)
    end

    def self.call(message)
      self.new.notify(message)
    end
  end
end
