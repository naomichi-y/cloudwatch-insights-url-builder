require 'url'
require 'cloudwatch_logs_insights_url_builder/criteria'

class CloudWatchLogsInsightsUrlBuilder
  attr_accessor :time_type, :timezone, :start_time, :end_time

  STRING_TIME_FORMAT = '%Y-%m-%dT%T.000Z'.freeze

  def initialize(region)
    @region = region
    @time_type = 'RELATIVE'
    @timezone = 'Local'
    @unit = 'minutes'
    @start_time = -86_400
    @end_time = 0
  end

  def log_insights_url(query, log_groups = [])
    url = +"https://#{@region}.console.aws.amazon.com/cloudwatch/home?region=#{@region}#logsV2:logs-insights"
    url << URI.encode_www_form_component('?queryDetail=').gsub('%', '$')

    start_time = @start_time.is_a?(Time) ? @start_time.strftime(STRING_TIME_FORMAT) : @start_time
    end_time = @end_time.is_a?(Time) ? @end_time.strftime(STRING_TIME_FORMAT) : @end_time

    builder = CloudWatchLogsInsightsUrlBuilder::Criteria.new
    builder.add('end', end_time)
    builder.add('start', start_time)
    builder.add('timeType', @time_type)
    builder.add('unit', 'seconds') if @time_type == 'RELATIVE'
    builder.add('tz', @timezone)
    builder.add('editorString', query)
    builder.add('isLiveTail', false)
    builder.add('source', log_groups) if log_groups.size.positive?

    url << builder.build
    url
  end
end
