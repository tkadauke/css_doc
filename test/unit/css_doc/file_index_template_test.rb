require File.dirname(__FILE__) + "/../test_helper"

class CSSDoc::FileIndexTemplateTest < Test::Unit::TestCase
  def test_should_have_title
    assert_not_nil CSSDoc::FileIndexTemplate.new(mock).title
  end
  
  def test_should_return_template_name
    assert_equal 'file_index', CSSDoc::FileIndexTemplate.new(mock).template_name
  end
end
