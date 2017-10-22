module Web::Controllers::Heartbeats
  class Create
    include Web::Action

    def call(params)
      service = ::Glados::ActionService::HeartbeatCreate.new(request: request, params: params)
      result = service.call
      if result.success?
        success(payload: result.data)
      else
        error(code: result.code)
      end
    end
  end
end
