module Result
  class Base
    attr_reader :code, :data

    def initialize(code: :ok, data:, success: true)
      @code = code
      @data = data
      @success = success
    end

    def success?
      @success == true
    end

    def error?
      !success?
    end

    def then
      if success?
        yield self
      else
        self
      end
    end

    def then_data
      if success?
        yield self.data
      else
        self
      end
    end

    def catch
      if error?
        yield self
      else
        self
      end
    end
  end
end
