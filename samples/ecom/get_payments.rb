#!/usr/bin/env ruby

require 'json'

puts "🚀 KodyPay Ruby SDK Sample - GetPayments API"
puts "============================================="
puts "📦 Using kody-clientsdk-ruby gem from RubyGems"
puts

# Configuration - replace with your actual credentials
api_key = ENV['KODY_API_KEY'] || 'your-api-key-here'
store_id = ENV['KODY_STORE_ID'] || 'your-store-id-here'

begin
  # Require the published gem
  require 'kody'

  # Configure KodyPay SDK
  Kody.configure do |config|
    config.staging_ap!  # Use Asia-Pacific staging endpoint
    config.api_key = api_key
    config.store_id = store_id
  end

  puts "📡 Endpoint: #{Kody.configuration.endpoint}"
  puts "🔑 Store ID: #{Kody.configuration.store_id[0..8]}..."
  puts "🗝️ API Key: #{Kody.configuration.api_key[0..10]}..."
  puts

  # Create the stub using configuration
  stub = Com::Kodypay::Grpc::Ecom::V1::KodyEcomPaymentsService::Stub.new(
    Kody.configuration.endpoint,
    GRPC::Core::ChannelCredentials.new
  )

  request = Com::Kodypay::Grpc::Ecom::V1::GetPaymentsRequest.new(
    store_id: Kody.configuration.store_id,
    page_cursor: Com::Kodypay::Grpc::Ecom::V1::GetPaymentsRequest::PageCursor.new(
      page: 1,
      page_size: 10
    )
  )

  puts "📤 Making gRPC call to GetPayments API..."
  response = stub.get_payments(request, metadata: { 'x-api-key' => Kody.configuration.api_key })

  puts "🎉 SUCCESS! Response from KodyPay API:"
  puts "📊 Total payments: #{response.response.total}"

  if response.response.payments.empty?
    puts "📭 No payments found for this store"
  else
    response.response.payments.each_with_index do |payment, index|
      puts "\n💳 Payment #{index + 1}:"
      puts "   ID: #{payment.payment_id}"
      puts "   Status: #{payment.status}"
      puts "   Created: #{Time.at(payment.date_created.seconds).strftime('%Y-%m-%d %H:%M:%S')}"

      if payment.sale_data
        sale = payment.sale_data
        amount = (sale.amount_minor_units / 100.0).round(2)
        puts "   Amount: #{amount} #{sale.currency}"
        puts "   Order ID: #{sale.order_id}"
        puts "   Payment Ref: #{sale.payment_reference}"
      end
    end
  end

rescue GRPC::BadStatus => e
  puts "❌ gRPC API Error: #{e.code} - #{e.message}"
  puts "💡 Check your API credentials and store permissions"
rescue LoadError => e
  puts "❌ Missing dependency: #{e.message}"
  puts "💡 Install the gem with: gem install kody-clientsdk-ruby"
rescue => e
  puts "❌ Error: #{e.message}"
  puts "🔍 #{e.backtrace.first}"
end

puts "\n📚 Documentation:"
puts "   RubyGems: https://rubygems.org/gems/kody-clientsdk-ruby"
puts "   GitHub: https://github.com/KodyPay/kody-clientsdk-ruby"