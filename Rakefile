require "bundler/gem_tasks"
require "rspec/core/rake_task"

RSpec::Core::RakeTask.new(:spec)

desc "Generate protobuf and gRPC files (requires proto files from build process)"
task :generate_protos do
  proto_dir = "proto"
  lib_dir = "lib"
  
  unless Dir.exist?(proto_dir)
    puts "Proto directory not found. This task should be run during CI/CD build process."
    puts "For local development, use the GitHub Actions workflow to generate the Ruby gem."
    exit 1
  end
  
  # Generate Ruby files from proto
  sh "grpc_tools_ruby_protoc -I #{proto_dir} --ruby_out=#{lib_dir} --grpc_out=#{lib_dir} #{proto_dir}/com/kodypay/grpc/ecom/v1/ecom.proto"
  
  # Clean up
  rm_rf proto_dir
end

task default: :spec