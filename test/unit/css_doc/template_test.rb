require File.dirname(__FILE__) + "/../test_helper"

class CSSDoc::TemplateTest < Test::Unit::TestCase
  class TestTemplate < CSSDoc::Template
    def template_name
      'test'
    end
  end
  
  def test_should_render_template_and_layout
    File.expects(:read).returns('').twice
    2.times { ERB.expects(:new).returns(mock(:result)) }
    template = TestTemplate.new
    template.render
  end
  
  def test_should_have_no_title
    assert_nil TestTemplate.new.title
  end
  
  def test_should_read_template
    File.expects(:read).with(regexp_matches(/test.html.erb/))
    TestTemplate.new.template
  end
  
  def test_should_read_layout
    File.expects(:read).with(regexp_matches(/layout.html.erb/))
    TestTemplate.new.layout
  end
  
  def test_should_return_relative_root
    assert_equal '.', TestTemplate.new.relative_root
  end
  
  def test_should_truncate_string
    template = TestTemplate.new
    assert_equal 5, template.truncate('abcde', 100).size
    assert_equal 5, template.truncate('abcdefghij', 5).size
  end
end
