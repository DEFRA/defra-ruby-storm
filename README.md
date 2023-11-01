# DefraRuby::Storm

![Build Status](https://github.com/DEFRA/defra-ruby-storm/workflows/CI/badge.svg)
[![Maintainability Rating](https://sonarcloud.io/api/project_badges/measure?project=DEFRA_defra-ruby-storm&metric=sqale_rating)](https://sonarcloud.io/dashboard?id=DEFRA_defra-ruby-storm)
[![Coverage](https://sonarcloud.io/api/project_badges/measure?project=DEFRA_defra-ruby-storm&metric=coverage)](https://sonarcloud.io/dashboard?id=DEFRA_defra-ruby-storm)
[![Gem Version](https://badge.fury.io/rb/defra_ruby_storm.svg)](https://badge.fury.io/rb/defra_ruby_storm)
[![Licence](https://img.shields.io/badge/Licence-OGLv3-blue.svg)](http://www.nationalarchives.gov.uk/doc/open-government-licence/version/3)


Ruby client for Storm Web Services API

## Table of Contents

1. [Installation](#installation)
2. [Configuration](#configuration)
3. [Usage](#usage)
4. [Error Handling](#error-handling)
5. [Testing](#testing)

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'defra-ruby-storm'
```
And then execute
```sh
bundle install
```

Or install it yourself as:
```sh
gem install defra-ruby-storm
```

## Configuration

You just need to let the gem know the STORM_API_USERNAME AND STORM_API_PASSWORD for the Api access.

```ruby
# config/initializers/defra_ruby_storm.rb
require "defra_ruby/storm"

DefraRuby::Storm.configure do |config|
  config.storm_api_username = "STORM_API_USERNAME"
  config.storm_api_password = "STORM_API_PASSWORD"
end
```

## Usage

The gem provides 3 separate services a host app can use:

- DefraRuby::Storm::UserDetailsService
- DefraRuby::Storm::PauseCallRecordingService
- DefraRuby::Storm::ResumeCallRecordingService


### User Details Service

```ruby
DefraRuby::Storm::UserDetailsService.run(username: 'TestAgentUsername')

#<DefraRuby::Storm::GetUserDetailsResponse:0x00007f6b9a3c5160
 @alternative_number=nil,                        
 @code="0",
 @first_name="First Name",
 @home_tel=nil,
 @last_name="Last Name",
 @mobile=nil,
 @personal_email=nil,
 @user_id="123",
 @user_name="TestAgentUsername",
 @work_email=nil,
 @work_tel=nil>
```
code "0" in api response suggests that the request has been handled successfully

### Pause Call Recording Service

```ruby
DefraRuby::Storm::PauseCallRecordingService.run(username: 'TestAgentUsername')

#<DefraRuby::Storm::RecordingResponse:0x00007f6b99c0f9e8 @result="0">
```
result code "0" in api response suggests that the request has been handled successfully

Knowing the agent's user ID, we can pass that into the service, eliminating the need for an additional API call and making request much faster.

```ruby
DefraRuby::Storm::PauseCallRecordingService.run(agent_user_id: 123)
```

### Resume Call Recording Service

```ruby
DefraRuby::Storm::ResumeCallRecordingService.run(username: 'TestAgentUsername')

#<DefraRuby::Storm::RecordingResponse:0x00007f6b99c0f9e8 @result="0">
```
result code "0" in api response suggests that the request has been handled successfully

Knowing the agent's user ID, we can pass that into the service, eliminating the need for an additional API call and making request much faster.

```ruby
DefraRuby::Storm::ResumeCallRecordingService.run(agent_user_id: 123)
```

## Error Handling

Errors are handled through the DefraRuby::Storm::ApiError class. Here's an example of how you can handle errors:
```ruby
begin
  # some code that might raise an error
rescue DefraRuby::Storm::ApiError => e
  puts "An error occurred: #{e.message}"
end
```

## Testing

```
bundle exec rspec
```
