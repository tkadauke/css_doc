require File.dirname(__FILE__) + "/../test_helper"

class CSSDoc::SelectorIndexTemplateTest < Test::Unit::TestCase
  def test_should_render_selector_index_template
    css1 = "img { width: 100%; }"
    css2 = "a.big { display: none; }"

    collection = CSSDoc::DocumentCollection.new
    collection.documents << CSSDoc::Document.parse(css1, 'something.css')
    collection.documents << CSSDoc::Document.parse(css2, 'something_else.css')
    
    template = CSSDoc::SelectorIndexTemplate.new(collection)
    
    result = template.render
    assert result =~ /img/
    assert result =~ /a.big/
  end
end
