require_relative "base"

module Result
  def self.Error(code: :ko, data: nil)
    Base.new(code: code, data: data, success: false)
  end
end
