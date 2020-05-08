# frozen_string_literal: true

require_relative "lib/radix_encoding/version"

Gem::Specification.new do |spec|
  spec.name          = "radix_encoding"
  spec.version       = RadixEncoding::VERSION
  spec.authors       = ["Pedro Costa"]
  spec.email         = ["pedro@subvisual.com"]
  spec.license       = "MIT"

  spec.summary       = "Encode data in any base and alphabet"
  spec.description   = <<~DESCRIPTION
    Binary to text encoding of data is commonly used for transmission when the
    channel does not support binary data. Common formats are Base16 (also known
    as hexadecimal), Base32, and Base64.

    However it is possible to encode data into any base, given an alphabet with
    that length. This tool allows the creation of an encoder for any base and
    alphabet, handling the special case where the base is not a power of 2.
  DESCRIPTION
  spec.homepage = "https://github.com/subvisual/ruby-radix-encoding"
  spec.required_ruby_version = Gem::Requirement.new(">= 2.3.0")

  spec.metadata["allowed_push_host"] = "https://rubygems.org"

  spec.metadata["homepage_uri"] = spec.homepage
  spec.metadata["source_code_uri"] = "https://github.com/subvisual/ruby-radix-encoding"
  spec.metadata["changelog_uri"] = "https://github.com/subvisual/ruby-radix-encoding/blob/master/CHANGELOG.md"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added
  # into git.
  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(bin|spec)/}) }
  end
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "activesupport", ">= 3.0"
  spec.add_dependency "subvisual-utils", "~> 0.x"
end
