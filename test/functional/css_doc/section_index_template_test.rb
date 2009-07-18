require File.dirname(__FILE__) + "/../test_helper"

class CSSDoc::SectionIndexTemplateTest < Test::Unit::TestCase
  def test_should_render_section_index_template
    css1 = <<-end
      /**
      * @section Images
      */
      img { width: 100%; }
    end

    css2 = <<-end
      /**
      * @section Links
      */
      a { display: none; }
    end

    collection = CSSDoc::DocumentCollection.new
    collection.documents << CSSDoc::Document.parse(css1, 'something.css')
    collection.documents << CSSDoc::Document.parse(css2, 'something_else.css')
    
    template = CSSDoc::SectionIndexTemplate.new(collection)
    
    result = template.render
    assert result =~ /Images/
    assert result =~ /Links/
  end
end
