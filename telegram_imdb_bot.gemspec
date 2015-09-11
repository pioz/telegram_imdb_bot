# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'telegram_imdb_bot/version'

Gem::Specification.new do |spec|
  spec.name          = "telegram_imdb_bot"
  spec.version       = TelegramImdbBot::VERSION
  spec.authors       = ["pioz"]
  spec.email         = ["enrico@megiston.it"]

  spec.summary       = %q{Telegram bot that retrieves movies info through IMDB}
  spec.description   = %q{Telegram bot that retrieves movies info through IMDB}
  spec.homepage      = "https://github.com/pioz/telegram_imdb_bot"
  spec.license       = "MIT"

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  # if spec.respond_to?(:metadata)
  #   spec.metadata['allowed_push_host'] = "TODO: Set to 'http://mygemserver.com'"
  # else
  #   raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  # end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  #spec.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.add_dependency "telegram-bot-ruby"
  spec.add_dependency "imdb"
  spec.add_dependency "daemons"

end
