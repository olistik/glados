class SettingRepository < Hanami::Repository
  def api_key
    settings.
      where(key: "api_key").
      first
  end
end
