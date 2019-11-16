lib = File.expand_path("lib", __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "gravedigger/version"

Gem::Specification.new do |spec|
  spec.name          = "gravedigger"
  spec.version       = Gravedigger::VERSION
  spec.authors       = ["Oğuzhan Göller"]
  spec.email         = ["goller.oguzhan@gmail.com"]

  spec.summary       = "Find and remove dead code from your project"
  spec.description   = "Gravedigger iterates through your project searching unused \
  methods and constants, helping you detect and eliminate dead code."
  spec.homepage      = "https://github.com/oguzhangoller/gravedigger"
  spec.license       = "MIT"

  # Specify which files should be added to the gem when it is released.
  # The `git ls-files -z` loads the files in the RubyGem that have been added into git.
  spec.files         = Dir.chdir(File.expand_path('..', __FILE__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 2.0"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "minitest", "~> 5.0"
end
