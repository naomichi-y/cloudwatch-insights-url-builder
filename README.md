# cloudwatch-logs-url-builder

![rspec](https://github.com/naomichi-y/cloudwatch-logs-url-builder/actions/workflows/rspec.yml/badge.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Generate AWS Console URL for Amazon CloudWatch.

## Installation

```
gem 'cloudwatch-logs-url-builder'
```

## Usage

```ruby
require 'cloudwatch-logs-url-builder'

builder = CloudWatchLogsUrlBuilder.new('ap-northeast-1')
builder.time_type = 'ABSOLUTE'
builder.start_time = start_time
builder.end_time = end_time

# https://ap-northeast-1.console.aws.amazon.com/cloudwatch/home?...
builder.log_insights_url(
  "fields @timestamp, @message, @logStream, @log\n| sort @timestamp desc\n| limit 20",
  ['/aws/cloudtrail']
)
```
