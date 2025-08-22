# KodyPay Ruby SDK

Ruby gRPC client for KodyPay payment APIs.

## Installation

```bash
gem install kody-clientsdk-ruby
```

## Quick Start

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

request = Com::Kodypay::Grpc::Ecom::V1::GetPaymentsRequest.new(
  store_id: Kody.configuration.store_id,
  page_cursor: Com::Kodypay::Grpc::Ecom::V1::GetPaymentsRequest::PageCursor.new(
    page: 1, page_size: 10
  )
)

response = ecom_stub.get_payments(request, metadata: { 'x-api-key' => Kody.configuration.api_key })
```

## Endpoints

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

## Samples

- [`samples/ecom/get_payments.rb`](samples/ecom/get_payments.rb) - eCommerce API
- [`samples/pos/get_terminals.rb`](samples/pos/get_terminals.rb) - Terminal API

## Documentation

📚 [API Documentation](https://api-docs.kody.com)  
📦 [RubyGems](https://rubygems.org/gems/kody-clientsdk-ruby)

## License

MIT