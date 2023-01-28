# cloudwatch_logs_url_builder

![rspec](https://github.com/naomichi-y/cloudwatch_logs_insights_url_builder/actions/workflows/rspec.yml/badge.svg)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

Generate AWS Console URL for Amazon CloudWatch Insights.

## Installation

```ruby
gem 'cloudwatch_logs_insights_url_builder'
```

## Usage

```ruby
require 'cloudwatch_logs_insights_url_builder'

now = Time.now

builder = CloudWatchLogsInsightsUrlBuilder.new
builder.time_type = 'ABSOLUTE'
builder.start_time = Time.utc(2023, 1, 27, 0, 0, 0)
builder.end_time = Time.utc(2023, 1, 27, 23, 59, 59)
builder.timezone = 'UTC'
builder.log_groups = ['/aws/cloudtrail']

# https://us-east-1.console.aws.amazon.com/cloudwatch/home?...
builder.log_insights_url("fields @timestamp, @message, @logStream, @log\n| sort @timestamp desc\n| limit 2")
```
The generated URL can be used to open the CloudWatch Insights page from a browser.

<img width="80%" alt="Screen Shot 2023-01-28 at 19 11 34" src="https://user-images.githubusercontent.com/1632478/215260832-885365d6-7216-4ea7-9b4d-292787297f7d.png">
