module Web
  module HTTPResponse
    def error(code:)
      halt 400, JSON.generate({code: code})
    end

    def success(code: 200, payload: {})
      status code, JSON.generate(payload)
    end
  end
end
