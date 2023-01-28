require './lib/cloudwatch_logs_insights_url_builder'

describe CloudWatchLogsInsightsUrlBuilder do
  describe '#log_insights_url' do
    context 'when searching by absolute date' do
      it 'should be returned URL' do
        now = Time.now
        start_time = now - 86_400
        end_time = now

        builder = CloudWatchLogsInsightsUrlBuilder.new('ap-northeast-1')
        builder.time_type = 'ABSOLUTE'
        builder.start_time = start_time
        builder.end_time = end_time
        builder.log_groups =  ['/aws/cloudtrail']
        url = builder.log_insights_url(
          "fields @timestamp, @message, @logStream, @log\n| sort @timestamp desc\n| limit 20"
        )

        expect_url = +'https://ap-northeast-1.console.aws.amazon.com/cloudwatch/home?'
        expect_url << 'region=ap-northeast-1#logsV2:logs-insights$3F'
        expect_url << 'queryDetail$3D$257E$2528'
        expect_url << "end$257E$2527#{URI.encode_www_form_component(end_time.strftime('%Y-%m-%dT%T.000Z')).gsub('%', '*')}$257E"
        expect_url << "start$257E$2527#{URI.encode_www_form_component(start_time.strftime('%Y-%m-%dT%T.000Z')).gsub('%', '*')}$257E"
        expect_url << 'timeType$257E$2527ABSOLUTE$257E'
        expect_url << 'tz$257E$2527Local$257E'
        expect_url << 'editorString$257E$2527fields+*40timestamp*2C+*40message*2C+*40logStream*2C+*40log*0A*7C+sort+*40timestamp+desc*0A*7C+limit+20$257E'
        expect_url << 'isLiveTail$257Efalse$257E'
        expect_url << 'source$257E$2528$257E'
        expect_url << '$2527*2Faws*2Fcloudtrail$2529$2529'

        expect(url).to eq(expect_url)
      end
    end

    context 'when searching by relative date' do
      context 'when default condition' do
        it 'should be returned URL' do
          builder = CloudWatchLogsInsightsUrlBuilder.new('ap-northeast-1')
          builder.time_type = 'RELATIVE'
          builder.log_groups =  ['/aws/cloudtrail']
          url = builder.log_insights_url(
            "fields @timestamp, @message, @logStream, @log\n| sort @timestamp desc\n| limit 20",
          )

          expect_url = +'https://ap-northeast-1.console.aws.amazon.com/cloudwatch/home?'
          expect_url << 'region=ap-northeast-1#logsV2:logs-insights$3F'
          expect_url << 'queryDetail$3D$257E$2528'
          expect_url << 'end$257E0$257E'
          expect_url << 'start$257E-86400$257E'
          expect_url << 'timeType$257E$2527RELATIVE$257E'
          expect_url << 'unit$257E$2527seconds$257E'
          expect_url << 'tz$257E$2527Local$257E'
          expect_url << 'editorString$257E$2527fields+*40timestamp*2C+*40message*2C+*40logStream*2C+*40log*0A*7C+sort+*40timestamp+desc*0A*7C+limit+20$257E'
          expect_url << 'isLiveTail$257Efalse$257E'
          expect_url << 'source$257E$2528$257E'
          expect_url << '$2527*2Faws*2Fcloudtrail$2529$2529'

          expect(url).to eq(expect_url)
        end
      end

      context 'when range is specified' do
        it 'should be returned URL' do
          start_time = -86_400
          end_time = 0

          builder = CloudWatchLogsInsightsUrlBuilder.new('ap-northeast-1')
          builder.time_type = 'RELATIVE'
          builder.start_time = start_time
          builder.end_time = end_time
          builder.log_groups =  ['/aws/cloudtrail']
          url = builder.log_insights_url(
            "fields @timestamp, @message, @logStream, @log\n| sort @timestamp desc\n| limit 20"
          )

          expect_url = +'https://ap-northeast-1.console.aws.amazon.com/cloudwatch/home?'
          expect_url << 'region=ap-northeast-1#logsV2:logs-insights$3F'
          expect_url << 'queryDetail$3D$257E$2528'
          expect_url << "end$257E#{end_time}$257E"
          expect_url << "start$257E#{start_time}$257E"
          expect_url << 'timeType$257E$2527RELATIVE$257E'
          expect_url << 'unit$257E$2527seconds$257E'
          expect_url << 'tz$257E$2527Local$257E'
          expect_url << 'editorString$257E$2527fields+*40timestamp*2C+*40message*2C+*40logStream*2C+*40log*0A*7C+sort+*40timestamp+desc*0A*7C+limit+20$257E'
          expect_url << 'isLiveTail$257Efalse$257E'
          expect_url << 'source$257E$2528$257E'
          expect_url << '$2527*2Faws*2Fcloudtrail$2529$2529'

          expect(url).to eq(expect_url)
        end
      end
    end
  end
end
