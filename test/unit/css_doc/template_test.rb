require File.dirname(__FILE__) + "/../test_helper"

class CSSDoc::TemplateTest < Test::Unit::TestCase
  class TestTemplate < CSSDoc::Template
    def initialize(options = {})
      super
    end
  end
  
  def test_should_render_template_and_layout
    File.expects(:read).returns('').twice
    2.times { ERB.expects(:new).returns(mock(:result)) }
    template = TestTemplate.new
    template.render('test')
  end
  
  def test_should_have_no_title
    assert_nil TestTemplate.new.title
  end
  
  def test_should_read_template
    File.expects(:read).with(regexp_matches(/test.html.erb/))
    TestTemplate.new.template('test')
  end
  
  def test_should_read_layout
    File.expects(:read).with(regexp_matches(/layout.html.erb/))
    TestTemplate.new.layout
  end
  
  def test_should_use_default_template_if_none_specified
    File.expects(:read).with(regexp_matches(/default/))
    TestTemplate.new.layout
  end
  
  def test_should_support_custom_templates
    File.expects(:read).with(regexp_matches(/my_own_template/))
    TestTemplate.new(:template_path => 'my_own_template').layout
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
