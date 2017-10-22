task health_check: :environment do
  Glados::HealthCheck.().
    then_data { |records| Glados::HealthCheckNotifier.(records: records) }.
    then { Hanami.logger.info "[Health Check] Done" }.
    catch { |result| Hanami.logger.error "[Health Check] Error [code:#{result.code}]" }
end
