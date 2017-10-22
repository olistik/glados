module Glados
  class ValidateAPIKey
    def self.call(api_key)
      setting_repository = SettingRepository.new
      if api_key != setting_repository.api_key.value
        Result::Error(code: :invalid_api_key)
      else
        Result::Success()
      end
    end
  end
end
