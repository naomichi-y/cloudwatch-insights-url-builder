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

builder = CloudWatchLogsInsightsUrlBuilder.new
builder.time_type = 'ABSOLUTE'
builder.start_time = 24 * 3600
builder.end_time = 0
builder.log_groups = ['/aws/cloudtrail']

# https://us-east-1.console.aws.amazon.com/cloudwatch/home?...
builder.log_insights_url("fields @timestamp, @message, @logStream, @log\n| sort @timestamp desc\n| limit 2")
```
The generated URL can be used to open the CloudWatch Insights page from a browser.

<img width="80%" alt="Screen Shot 2023-01-28 at 12 45 11" src="https://user-images.githubusercontent.com/1632478/215240546-417c523e-692f-47eb-8d01-ccca215d348b.png">
