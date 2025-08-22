#!/usr/bin/env ruby

puts "🚀 KodyPay Ruby SDK Sample - GetTerminals API"
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

  # Create the Terminal API stub using configuration
  stub = Com::Kodypay::Grpc::Pay::V1::KodyPayTerminalService::Stub.new(
    Kody.configuration.endpoint,
    GRPC::Core::ChannelCredentials.new
  )

  request = Com::Kodypay::Grpc::Pay::V1::TerminalsRequest.new(
    store_id: Kody.configuration.store_id
  )

  puts "📤 Making gRPC call to GetTerminals API..."
  response = stub.terminals(request, metadata: { 'x-api-key' => Kody.configuration.api_key })

  puts "🎉 SUCCESS! Response from KodyPay Terminal API:"
  puts "🖥️ Total terminals: #{response.terminals.length}"

  if response.terminals.empty?
    puts "📭 No terminals found for this store"
  else
    response.terminals.each_with_index do |terminal, index|
      status = terminal.online ? "🟢 Online" : "🔴 Offline"
      puts "\n🖥️ Terminal #{index + 1}:"
      puts "   ID: #{terminal.terminal_id}"
      puts "   Status: #{status}"
      
      if terminal.respond_to?(:last_activity_at) && terminal.last_activity_at
        last_activity = Time.at(terminal.last_activity_at.seconds).strftime('%Y-%m-%d %H:%M:%S')
        puts "   Last Activity: #{last_activity}"
      end
      
      if terminal.respond_to?(:version) && terminal.version && !terminal.version.empty?
        puts "   Version: #{terminal.version}"
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