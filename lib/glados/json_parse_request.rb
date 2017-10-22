module Glados
  class JSONParseRequest
    def self.call(request)
      data = JSON.parse(request.body.read)
      Result::Success(data: data)
    rescue JSON::ParserError
      Result::Error(code: :json_parser_error)
    end
  end
end
