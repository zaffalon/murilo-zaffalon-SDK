$LOAD_PATH.unshift(::File.join(::File.dirname(__FILE__), "lib"))

Gem::Specification.new do |s|
  s.name = "elessar"
  s.version = "0.0.1"
  s.required_ruby_version = ">= 2.3.0"

  s.authors = ["Murilo Zaffalon"]
  s.date = %q{2023-03-05}
  s.description = %q{A simple SDK for Murilo Zaffalon, Elessar - In the book, Elessar is a green gemstone that is a symbol of the kingship of Gondor.}
  s.email = %q{mzaffalon@hotmail.com}
  # s.test_files = ["test/test_hola.rb"]
  s.homepage = %q{http://rubygems.org/gems/elessar}
  s.summary = %q{Murilo Zaffalon SDK!}

  ignored = Regexp.union(
    "elessar-0.0.1.gem",
    /\A\.git/,
    /\A\.vscode/,
    /\Atest/
  )
  s.files = `git ls-files`.split("\n").reject { |f| ignored.match(f) }
  s.executables   = `git ls-files -- bin/*`.split("\n")
                                           .map { |f| ::File.basename(f) }
  s.require_paths = ["lib"]
end
