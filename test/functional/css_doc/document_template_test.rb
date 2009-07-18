require File.dirname(__FILE__) + "/../test_helper"

class CSSDoc::DocumentTemplateTest < Test::Unit::TestCase
  def test_should_render_document_template
    css = <<-end
      /**
      * @file something.css
      * This file is awesome
      * @author John Doe
      */
      img { width: 100%; }
      a { display: none; }
    end
    document = CSSDoc::Document.parse(css, 'something.css')
    template = CSSDoc::DocumentTemplate.new(document)
    result = template.render
    assert result =~ /This file is awesome/
    assert result =~ /John Doe/
    assert result =~ /width: 100.0%/
    assert result =~ /display: none/
  end
end
