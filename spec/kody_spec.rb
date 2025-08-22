# Test the core SDK functionality without depending on generated gRPC files
require_relative '../lib/kody/version'
require_relative '../lib/kody/configuration'

RSpec.describe "Kody SDK" do
  it "has a version number" do
    expect(Kody::VERSION).not_to be nil
  end

  describe Kody::Configuration do
    let(:config) { Kody::Configuration.new }

    it "has default production endpoint" do
      expect(config.endpoint).to eq(Kody::Configuration::PRODUCTION_ENDPOINT)
    end

    it "can switch to staging" do
      config.staging!
      expect(config.endpoint).to eq(Kody::Configuration::STAGING_ENDPOINT)
    end

    it "can switch to staging AP" do
      config.staging_ap!
      expect(config.endpoint).to eq(Kody::Configuration::STAGING_AP_ENDPOINT)
    end

    it "can switch to staging EU" do
      config.staging_eu!
      expect(config.endpoint).to eq(Kody::Configuration::STAGING_EU_ENDPOINT)
    end

    it "allows setting api_key and store_id" do
      config.api_key = "test-key"
      config.store_id = "test-store"

      expect(config.api_key).to eq("test-key")
      expect(config.store_id).to eq("test-store")
    end
  end
end

# Test the main Kody module and gRPC integration (only if files exist)
RSpec.describe Kody do
  # This will only run if the generated files exist (like in the built gem)
  context "when gRPC files are generated" do
    it "can load the main module" do
      begin
        load File.expand_path('../lib/kody.rb', __dir__)

        expect(defined?(Kody)).to be_truthy
        expect(Kody).to respond_to(:configure)

        # Test configuration if module loaded successfully
        Kody.configure do |config|
          config.api_key = "test-key"
          config.store_id = "test-store"
        end

        expect(Kody.configuration.api_key).to eq("test-key")
        expect(Kody.configuration.store_id).to eq("test-store")

      rescue LoadError => e
        # Skip gRPC tests if generated files don't exist (development)
        skip "gRPC files not generated: #{e.message}"
      end
    end

    it "loads gRPC classes when available" do
      begin
        load File.expand_path('../lib/kody.rb', __dir__)

        expect(defined?(Com::Kodypay::Grpc::Ecom::V1::KodyEcomPaymentsService)).to be_truthy
        expect(defined?(Com::Kodypay::Grpc::Ecom::V1::GetPaymentsRequest)).to be_truthy
        expect(defined?(Com::Kodypay::Grpc::Ecom::V1::GetPaymentsResponse)).to be_truthy

      rescue LoadError => e
        skip "gRPC files not generated: #{e.message}"
      end
    end
  end
end