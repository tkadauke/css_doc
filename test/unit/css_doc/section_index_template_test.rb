require File.dirname(__FILE__) + "/../test_helper"

class CSSDoc::SectionIndexTemplateTest < Test::Unit::TestCase
  def test_should_have_title
    assert_not_nil CSSDoc::SectionIndexTemplate.new(mock).title
  end
  
  def test_should_return_template_name
    assert_equal 'section_index', CSSDoc::SectionIndexTemplate.new(mock).template_name
  end
end
