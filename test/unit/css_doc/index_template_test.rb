require File.dirname(__FILE__) + "/../test_helper"

class CSSDoc::IndexTemplateTest < Test::Unit::TestCase
  def test_should_have_title
    assert_not_nil CSSDoc::IndexTemplate.new({}).title
  end
  
  def test_should_return_template_name
    assert_equal 'index', CSSDoc::IndexTemplate.new({}).template_name
  end
end
