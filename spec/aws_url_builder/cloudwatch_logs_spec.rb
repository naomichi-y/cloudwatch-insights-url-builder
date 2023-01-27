require './lib/aws_url_builder/cloudwatch_logs'

describe AwsUrlBuilder::CloudWatchLogs do
  describe '#log_insights_url' do
    context 'when searching by absolute date' do
      it 'should be returned URL' do
        now = Time.now
        start_time = now - 86400
        end_time = now

        builder = AwsUrlBuilder::CloudWatchLogs.new('ap-northeast-1')
        builder.time_type = 'ABSOLUTE'
        builder.timezone = 'Local'
        builder.start_time = start_time
        builder.end_time = end_time
        url = builder.log_insights_url(
          "fields @message \n| filter errorCode = 'AccessDenied' \n| sort @timestamp asc \n| limit 20",
          ['/aws/cloudtrail', '/aws/ecs/development-app']
        )

        expect_url = +"https://ap-northeast-1.console.aws.amazon.com/cloudwatch/home?"
        expect_url << "region=ap-northeast-1#logsV2:logs-insights$3F"
        expect_url << "queryDetail$3D$257E$2528"
        expect_url << "end$257E$2527#{URI.encode_www_form_component(end_time.strftime('%Y-%m-%dT%T.000Z')).gsub('%', '*')}$257E"
        expect_url << "start$257E$2527#{URI.encode_www_form_component(start_time.strftime('%Y-%m-%dT%T.000Z')).gsub('%', '*')}$257E"
        expect_url << "timeType$257E$2527ABSOLUTE$257E"
        expect_url << "tz$257E$2527Local$257E"
        expect_url << "editorString$257E$2527fields+*40message+*0A*7C+filter+errorCode+*3D+*27AccessDenied*27+*0A*7C+sort+*40timestamp+asc+*0A*7C+limit+20$257E"
        expect_url << "isLiveTail$257Efalse$257E"
        expect_url << "source$257E$2528$257E"
        expect_url << "$2527*2Faws*2Fcloudtrail$257E$2527*2Faws*2Fecs*2Fdevelopment-app$2529$2529"

        expect(url).to eq(expect_url)
      end
    end

    context 'when searching by relative date' do
      it 'should be returned URL' do
        start_time = -86400
        end_time = 0

        builder = AwsUrlBuilder::CloudWatchLogs.new('ap-northeast-1')
        builder.time_type = 'RELATIVE'
        builder.timezone = 'Local'
        builder.start_time = start_time
        builder.end_time = end_time
        url = builder.log_insights_url(
          "fields @message \n| filter errorCode = 'AccessDenied' \n| sort @timestamp asc \n| limit 20",
          ['/aws/cloudtrail', '/aws/ecs/development-app']
        )

        expect_url = +"https://ap-northeast-1.console.aws.amazon.com/cloudwatch/home?"
        expect_url << "region=ap-northeast-1#logsV2:logs-insights$3F"
        expect_url << "queryDetail$3D$257E$2528"
        expect_url << "end$257E#{end_time}$257E"
        expect_url << "start$257E#{start_time}$257E"
        expect_url << "timeType$257E$2527RELATIVE$257E"
        expect_url << "unit$257E$2527seconds$257E"
        expect_url << "tz$257E$2527Local$257E"
        expect_url << "editorString$257E$2527fields+*40message+*0A*7C+filter+errorCode+*3D+*27AccessDenied*27+*0A*7C+sort+*40timestamp+asc+*0A*7C+limit+20$257E"
        expect_url << "isLiveTail$257Efalse$257E"
        expect_url << "source$257E$2528$257E"
        expect_url << "$2527*2Faws*2Fcloudtrail$257E$2527*2Faws*2Fecs*2Fdevelopment-app$2529$2529"

        puts url
        puts expect_url
        expect(url).to eq(expect_url)
      end
    end
  end
end
