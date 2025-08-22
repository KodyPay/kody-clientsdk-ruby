require_relative 'kody/version'
require_relative 'kody/configuration'

# Load gRPC protobuf definitions and services (generated during build)
begin
  require 'grpc'
  
  # Automatically load all generated protobuf files
  lib_dir = File.dirname(__FILE__)
  
  # Load all _pb.rb files (protobuf messages)
  Dir.glob(File.join(lib_dir, '*_pb.rb')).each do |file|
    require file
  end
  
  # Load all _services_pb.rb files (gRPC services) 
  Dir.glob(File.join(lib_dir, '*_services_pb.rb')).each do |file|
    require file
  end
  
rescue LoadError => e
  raise LoadError, "KodyPay gRPC files not found. This gem must be installed from RubyGems to include generated protobuf files. Error: #{e.message}"
end

module Kody
  class << self
    attr_accessor :configuration
  end

  def self.configure
    self.configuration ||= Configuration.new
    yield(configuration)
  end

  class Error < StandardError; end
end