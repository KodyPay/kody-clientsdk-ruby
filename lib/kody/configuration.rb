module Kody
  class Configuration
    # KodyPay gRPC endpoints by region
    # Production endpoints
    PRODUCTION_ENDPOINT = 'grpc.kodypay.com:443'          # Default
    PRODUCTION_AP_ENDPOINT = 'grpc-ap.kodypay.com:443'    # Asia-Pacific
    PRODUCTION_EU_ENDPOINT = 'grpc-eu.kodypay.com:443'    # Europe
    
    # Staging endpoints  
    STAGING_ENDPOINT = 'grpc-staging.kodypay.com:443'     # Default
    STAGING_AP_ENDPOINT = 'grpc-staging-ap.kodypay.com:443' # Asia-Pacific
    STAGING_EU_ENDPOINT = 'grpc-staging-eu.kodypay.com:443' # Europe

    attr_accessor :api_key, :store_id, :endpoint

    def initialize
      @endpoint = PRODUCTION_ENDPOINT
    end

    def staging!
      @endpoint = STAGING_ENDPOINT
    end

    def staging_ap!
      @endpoint = STAGING_AP_ENDPOINT
    end

    def staging_eu!
      @endpoint = STAGING_EU_ENDPOINT
    end

    def production!
      @endpoint = PRODUCTION_ENDPOINT
    end

    def production_ap!
      @endpoint = PRODUCTION_AP_ENDPOINT
    end

    def production_eu!
      @endpoint = PRODUCTION_EU_ENDPOINT
    end
  end
end