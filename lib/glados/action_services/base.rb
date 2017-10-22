module Glados
  module ActionService
    class Base
      attr_accessor :request, :params

      def initialize(request:, params:)
        self.request = request
        self.params = params
      end
    end
  end
end
