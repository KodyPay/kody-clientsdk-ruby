require_relative 'lib/kody/version'

Gem::Specification.new do |spec|
  spec.name          = "kody-clientsdk-ruby"
  spec.version       = Kody::VERSION
  spec.authors       = ["Kody Tech Team"]
  spec.email         = ["tech@kody.com"]
  spec.summary       = "Ruby gRPC client for Kody payment services"
  spec.description   = "A Ruby client library for integrating with Kody payment APIs using gRPC"
  spec.homepage      = "https://github.com/KodyPay/kody-clientsdk-ruby"
  spec.license       = "MIT"
  spec.required_ruby_version = ">= 2.6.10"
  
  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = spec.homepage
  spec.metadata["changelog_uri"] = "#{spec.homepage}/releases"
  spec.metadata["documentation_uri"] = "https://api-docs.kody.com"
  spec.metadata["bug_tracker_uri"] = "#{spec.homepage}/issues"
  
  # Specify which files should be added to the gem when it is released.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject do |f|
      (f == __FILE__) || f.match(%r{\A(?:(?:test|spec|features)/|\.(?:git|travis|circleci)|appveyor)})
    end
  end
  
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{\Aexe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]
  
  # Dependencies
  spec.add_dependency "grpc", ">= 1.74.0", "< 2.0"
  spec.add_dependency "google-protobuf", ">= 4.31.0", "< 5.0"
  
  # Development dependencies
  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 13.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "grpc-tools", "~> 1.74.0"
end