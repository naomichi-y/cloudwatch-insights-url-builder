require 'cgi'

class CloudWatchInsightsUrlBuilder
  class << self
    def build(region, time_type, timezone, start_time, end_time, query, log_groups)
      start_time = start_time.strftime('%Y-%m-%dT%T.000Z')
      end_time = end_time.strftime('%Y-%m-%dT%T.000Z')

      url = +"https://#{region}.console.aws.amazon.com/cloudwatch/home?region=#{region}#logsV2:logs-insights"
      url << URI.encode_www_form_component('?queryDetail=').gsub('%', '$')
      url << encode_key("~(end~'")
      url << encode_value(end_time)
      url << encode_key("~start~'")
      url << encode_value(start_time)
      url << encode_key("~timeType~'")
      url << encode_value(time_type)
      url << encode_key("~tz~'")
      url << encode_value(timezone)
      url << encode_key("~editorString~'")
      url << encode_value(query)
      url << encode_key("~isLiveTail~")
      url << encode_value("false")
      url << encode_key("~source~(")

      log_groups.each do |log_group|
        url << encode_key("~'")
        url << encode_value(log_group)
      end

      url << encode_key('))')
      url
    end

    private

    def encode_key(key)
      URI.encode_www_form_component(URI.encode_www_form_component(key)).gsub('%', '$')
    end

    def encode_value(value)
      URI.encode_www_form_component(value).gsub('%', '*')
    end
  end
end


now = Time.now
puts CloudWatchInsightsUrlBuilder.build(
  'ap-northeast-1',
  'ABSOLUTE',
  'Local',
  now - 86400,
  now,
  "fields @message \n| filter errorCode = 'AccessDenied' \n| sort @timestamp asc \n| limit 20",
  ['/aws/cloudtrail', '/aws/ecs/development-app']
)
