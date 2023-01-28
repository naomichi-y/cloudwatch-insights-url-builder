# cloudwatch_logs_url_builder

![rspec](https://github.com/naomichi-y/cloudwatch_logs_url_builder/actions/workflows/rspec.yml/badge.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Generate AWS Console URL for Amazon CloudWatch.

## Installation

```
gem 'cloudwatch_logs_url_builder'
```

## Usage

```ruby
require 'cloudwatch_logs_url_builder'

builder = CloudWatchLogsUrlBuilder.new
builder.time_type = 'ABSOLUTE'
builder.start_time = 24 * 3600
builder.end_time = 0

# https://us-east-1.console.aws.amazon.com/cloudwatch/home?...
builder.log_insights_url(
  "fields @timestamp, @message, @logStream, @log\n| sort @timestamp desc\n| limit 20",
  ['/aws/cloudtrail']
)
```
