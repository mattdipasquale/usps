Gem::Specification.new do |s|
  s.name = "usps"
  s.version = File.read('VERSION') rescue ""
  s.date = Time.now.strftime('%Y-%m-%d')
  s.summary = "USPS facilitates address standardization via USPS Webtools API."
  s.description = "USPS facilitates address standardization via USPS Webtools API."
  s.homepage = "http://github.com/mattdipasquale/usps"
  s.email = "liveloveprosper@gmail.com"
  s.authors = ["Matt Di Pasquale", "Chris Gaffney"]

  s.files = %w(README.md Rakefile MIT-LICENSE)
  s.files += Dir.glob("lib/**/*")
  s.files += Dir.glob("bin/**/*")
  s.files += Dir.glob("spec/**/*")
  s.files += Dir.glob("tasks/**/*")

  s.extra_rdoc_files = ["README.md"]
  s.rdoc_options = ["--charset=UTF-8"]

  s.add_dependency "nokogiri", ">= 1.4.1"
  s.add_development_dependency "rspec", ">= 2.0.0"
end
