Gem::Specification.new do |s|
  s.author            = 'Alexander Jentz'
  s.email             = 'me@beyama.de'
    
  s.platform          = Gem::Platform::RUBY
  s.name              = 'refinerycms-contacts'
  s.version           = '0.1.0'
  s.description       = 'Ruby on Rails Contacts engine for Refinery CMS'
  s.date              = '2011-07-28'
  s.summary           = 'Contacts engine for Refinery CMS'
  s.require_paths     = %w(lib)
  s.files             = Dir['lib/**/*', 'config/**/*', 'app/**/*', 'db/**/*', 'public/**/*']
end
