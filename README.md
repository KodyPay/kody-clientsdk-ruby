# Kody API - Ruby SDK

[![Gem Version](https://badge.fury.io/rb/kody-clientsdk-ruby.svg)](https://badge.fury.io/rb/kody-clientsdk-ruby)
[![Downloads](https://img.shields.io/gem/dt/kody-clientsdk-ruby.svg)](https://rubygems.org/gems/kody-clientsdk-ruby)
[![License](https://img.shields.io/badge/License-MIT-blue.svg)](https://opensource.org/licenses/MIT)
[![Ruby](https://img.shields.io/badge/ruby-%3E%3D%202.6.10-red.svg)](https://www.ruby-lang.org/)

This guide provides an overview of using the Kody API and its reference documentation.

- [Client Libraries](#client-libraries)
- [Ruby Installation](#ruby-installation)
- [Authentication](#authentication)
- [Documentation](#documentation)
- [Sample code](#sample-code)

## Client Libraries

Kody provides client libraries for many popular languages to access the APIs. If your desired programming language is supported by the client libraries, we recommend that you use this option.

Available languages:
- Java: https://github.com/KodyPay/kody-clientsdk-java/
- Python: https://github.com/KodyPay/kody-clientsdk-python/
- PHP: https://github.com/KodyPay/kody-clientsdk-php/
- .Net: https://github.com/KodyPay/kody-clientsdk-dotnet/
- Ruby: https://github.com/KodyPay/kody-clientsdk-ruby/

The advantages of using the Kody Client library instead of a REST API are:
- Maintained by Kody.
- Built-in authentication and increased security.
- Built-in retries.
- Idiomatic for each language.
- Quicker development.
- Backwards compatibility with new versions.

If your coding language is not listed, please let the Kody team know and we will be able to create it for you.

## Ruby Installation
### Requirements
- Ruby 2.6.10 and above
- Bundler (optional), recommended way to manage dependencies

Install the Kody Ruby Client SDK using gem:

```bash
gem install kody-clientsdk-ruby
```

Or add to your Gemfile:

```ruby
gem 'kody-clientsdk-ruby'
```

The library can also be downloaded from [RubyGems](https://rubygems.org/gems/kody-clientsdk-ruby).

### Import in code

```ruby
require 'kody'

# Configure SDK
Kody.configure do |config|
  config.staging_ap!  # Use Asia-Pacific staging
  config.api_key = 'your-api-key'
  config.store_id = 'your-store-id'
end

# eCommerce API
ecom_stub = Com::Kodypay::Grpc::Ecom::V1::KodyEcomPaymentsService::Stub.new(
  Kody.configuration.endpoint,
  GRPC::Core::ChannelCredentials.new
)

# Terminal API
terminal_stub = Com::Kodypay::Grpc::Pay::V1::KodyPayTerminalService::Stub.new(
  Kody.configuration.endpoint,
  GRPC::Core::ChannelCredentials.new
)

# Ordering API
ordering_stub = Com::Kodypay::Grpc::Ordering::V1::KodyOrderingService::Stub.new(
  Kody.configuration.endpoint,
  GRPC::Core::ChannelCredentials.new
)
```

## Authentication

The client library uses a combination of a `Store ID` and an `API key`.
These will be shared with you during the technical integration onboarding or by your Kody contact.

During development, you will have access to a **test Store** and **test API key**, and when the integration is ready for live access, the production credentials will be shared securely with you and associated with a live store that was onboarded on Kody.

The test and live API calls are always compatible, only changing credentials and the service hostname is required to enable the integration in production.

### Host names

Development and Test:
- Default: `grpc-staging.kodypay.com`
- For Asia-specific region: `grpc-staging-ap.kodypay.com`
- For Europe-specific region: `grpc-staging-eu.kodypay.com`

Live:
- Default: `grpc.kodypay.com`
- For Asia-specific region: `grpc-ap.kodypay.com`
- For Europe-specific region: `grpc-eu.kodypay.com`

### Endpoints Configuration

```ruby
# Production
config.production!      # grpc.kodypay.com:443
config.production_ap!   # grpc-ap.kodypay.com:443  
config.production_eu!   # grpc-eu.kodypay.com:443

# Staging  
config.staging!         # grpc-staging.kodypay.com:443
config.staging_ap!      # grpc-staging-ap.kodypay.com:443
config.staging_eu!      # grpc-staging-eu.kodypay.com:443
```

## Documentation

For complete API documentation, examples, and integration guides, please visit:
📚 https://api-docs.kody.com

## Sample code

- Java: https://github.com/KodyPay/kody-clientsdk-java/tree/main/samples
- Python: https://github.com/KodyPay/kody-clientsdk-python/tree/main/versions/3_12/samples
- PHP: https://github.com/KodyPay/kody-clientsdk-php/tree/main/samples
- .Net: https://github.com/KodyPay/kody-clientsdk-dotnet/tree/main/samples
- Ruby: https://github.com/KodyPay/kody-clientsdk-ruby/tree/main/samples