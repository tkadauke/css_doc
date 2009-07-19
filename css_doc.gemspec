spec = Gem::Specification.new do |s|
  s.name          = 'css_doc'
  s.version       = '0.0.3'
  s.summary       = "Documentation generator for CSS files, similar to Javadoc or RDoc."
  s.description   = %{Library and Executable that extracts documentation from CSS files.}
  s.files         = ["src/css_doc/css_writer.rb", "src/css_doc/document.rb", "src/css_doc/document_collection.rb", "src/css_doc/document_documentation.rb", "src/css_doc/document_handler.rb", "src/css_doc/documentation.rb", "src/css_doc/driver.rb", "src/css_doc/rule_set.rb", "src/css_doc/rule_set_documentation.rb", "src/css_doc/section.rb", "src/css_doc/section_documentation.rb", "src/css_doc/template.rb", "src/css_doc.rb", "src/css_pool/visitors/to_css.rb", "src/rake/css_doc_task.rb", "src/templates/default/css_doc.css", "src/templates/default/document.html.erb", "src/templates/default/file_index.html.erb", "src/templates/default/index.html.erb", "src/templates/default/layout.html.erb", "src/templates/default/section_index.html.erb", "src/templates/default/selector_index.html.erb", "src/templates/simple/css_doc.css", "src/templates/simple/document.html.erb", "src/templates/simple/file_index.html.erb", "src/templates/simple/index.html.erb", "src/templates/simple/layout.html.erb", "src/templates/simple/section_index.html.erb", "src/templates/simple/selector_index.html.erb"]
  s.date          = "2009-07-19"
  s.require_path  = 'src'
  s.bindir        = 'bin'
  s.executables   = ["cssdoc"]
  s.author        = "Thomas Kadauke"
  s.email         = "thomas.kadauke@imedo.de"
  s.homepage      = "http://www.imedo.de"
end
