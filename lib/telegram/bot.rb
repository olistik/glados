require "net/http"
require "json"
require "uri"

module Telegram
  class Bot
    def initialize(bot_token:)
      @bot_token = bot_token
    end

    def send_message(chat_id:, text:, parse_mode: "Markdown")
      data = {
        chat_id: chat_id,
        text: text,
        parse_mode: parse_mode,
      }
      call(path: "sendMessage", data: data)
    end

    private

    def call(path:, data: {})
      url = "https://api.telegram.org/bot#{@bot_token}/#{path}"
      uri = URI.parse(url)
      request = Net::HTTP::Post.new(uri)
      request.body = JSON.generate(data)
      request.content_type = "application/json"
      response = Net::HTTP.start(uri.host, uri.port, use_ssl: uri.scheme == "https") do |http|
        http.request(request)
      end
      case response
      when Net::HTTPOK
        response_data = JSON.parse(response.body)
        # TODO: catch JSON parser error
        if response_data["ok"]
          Result::Success.(data: response_data["result"])
        else
          Result::Error.(data: response)
        end
      else
        Result::Error.(code: :unknown_response_type, data: response)
      end
    rescue
    end
  end
end
