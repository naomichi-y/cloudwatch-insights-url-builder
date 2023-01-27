require 'url'
require './lib/aws_url_builder/cloudwatch_logs/criteria'

module AwsUrlBuilder
  class CloudWatchLogs
    attr_accessor :time_type, :timezone, :start_time, :end_time

    def initialize(region)
      @region = region
      @time_type = 'RELATIVE'
      @unit = 'minutes'
    end

    def log_insights_url(query, log_groups)
      url = +"https://#{@region}.console.aws.amazon.com/cloudwatch/home?region=#{@region}#logsV2:logs-insights"
      url << URI.encode_www_form_component('?queryDetail=').gsub('%', '$')
      string_time_format = '%Y-%m-%dT%T.000Z'

      start_time = @start_time.kind_of?(Time) ? @start_time.strftime(string_time_format) : @start_time
      end_time = @end_time.kind_of?(Time) ? @end_time.strftime(string_time_format) : @end_time

      builder = CloudWatchLogs::Criteria.new
      builder.add('end', end_time)
      builder.add('start', start_time)
      builder.add('timeType', @time_type)
      builder.add('unit', 'seconds') if @time_type == 'RELATIVE'
      builder.add('tz', @timezone)
      builder.add('editorString', query)
      builder.add('isLiveTail', false)
      builder.add('source', log_groups)
      url << builder.build

      url
    end
  end
end
