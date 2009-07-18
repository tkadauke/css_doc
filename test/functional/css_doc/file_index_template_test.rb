require File.dirname(__FILE__) + "/../test_helper"

class CSSDoc::FileIndexTemplateTest < Test::Unit::TestCase
  def test_should_render_file_index_template
    css1 = "img { width: 100%; }"
    css2 = "a { display: none; }"

    collection = CSSDoc::DocumentCollection.new
    collection.documents << CSSDoc::Document.parse(css1, 'something.css')
    collection.documents << CSSDoc::Document.parse(css2, 'something_else.css')
    
    template = CSSDoc::FileIndexTemplate.new(collection)
    
    result = template.render
    assert result =~ /something.css/
    assert result =~ /something_else.css/
  end
end
