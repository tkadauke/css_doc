require File.dirname(__FILE__) + "/../test_helper"

class CSSDoc::DocumentTemplateTest < Test::Unit::TestCase
  def test_should_have_title
    assert_equal 'something.css', CSSDoc::DocumentTemplate.new(mock(:name => 'something.css')).title
  end
  
  def test_should_return_template_name
    assert_equal 'document', CSSDoc::DocumentTemplate.new(mock).template_name
  end
  
  def test_should_find_correct_relative_root
    assert_equal '.', CSSDoc::DocumentTemplate.new(stub(:name => 'test.css')).relative_root
    assert_equal '..', CSSDoc::DocumentTemplate.new(stub(:name => 'a/test.css')).relative_root
    assert_equal '../..', CSSDoc::DocumentTemplate.new(stub(:name => 'a/b/test.css')).relative_root
  end
end
