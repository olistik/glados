require_relative "base"

module Result
  def self.Success(code: :ok, data: nil)
    Base.new(code: code, data: data)
  end
end
