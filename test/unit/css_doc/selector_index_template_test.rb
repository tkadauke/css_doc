require File.dirname(__FILE__) + "/../test_helper"

class CSSDoc::SelectorIndexTemplateTest < Test::Unit::TestCase
  def test_should_have_title
    assert_not_nil CSSDoc::SelectorIndexTemplate.new(mock).title
  end
  
  def test_should_return_template_name
    assert_equal 'selector_index', CSSDoc::SelectorIndexTemplate.new(mock).template_name
  end
end
