module Glados
  class HealthCheckNotifier
    def initialize(records:)
      self.records = records
    end

    def perform
      if records[:late].any?
        Glados::Notifier.(build_message)
      end
      Result::Success()
    end

    def self.call(records:)
      new(records: records).perform
    end

    private
    attr_accessor :records

    def build_message
      %{
        new late: #{records[:new_late].count}
        up to date: #{records[:up_to_date].count}
        not initialized: #{records[:not_init].count}

        ## Late

        #{build_late_records_message}
      }.strip.lines.map(&:strip).join("\n")
    end

    def build_late_records_message
      records[:late].map do |record|
        # TODO: add how much time has passed
        "- `#{record[:device].name}` last ping sent at `#{record[:heartbeat].formatted_time}`"
      end.join("\n")
    end
  end
end
