# cloudwatch_logs_url_builder

![rspec](https://github.com/naomichi-y/cloudwatch_logs_insights_url_builder/actions/workflows/rspec.yml/badge.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Generate AWS Console URL for Amazon CloudWatch Insights.

## Installation

```
gem 'cloudwatch_logs_insights_url_builder'
```

## Usage

```ruby
require 'cloudwatch_logs_insights_url_builder'

builder = CloudWatchLogsInsightsUrlBuilder.new
builder.time_type = 'ABSOLUTE'
builder.start_time = 24 * 3600
builder.end_time = 0

query = 'fields @timestamp, @message, @logStream, @log\n| sort @timestamp desc\n| limit 2'
log_groups = ['/aws/cloudtrail']

# https://us-east-1.console.aws.amazon.com/cloudwatch/home?...
builder.log_insights_url(query, log_groups)
```
