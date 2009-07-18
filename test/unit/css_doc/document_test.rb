require File.dirname(__FILE__) + "/../test_helper"

class CSSDoc::DocumentTest < Test::Unit::TestCase
  def test_should_create_section_on_initialization
    CSSDoc::Section.expects(:new)
    CSSDoc::Document.new('something.css')
  end
  
  def test_should_return_output_file_name
    CSSDoc::Section.stubs(:new)
    document = CSSDoc::Document.new('something.css')
    assert_equal 'something_css.html', document.output_file_name
  end
  
  def test_should_find_named_sections
    named_section = mock(:name => 'hello')
    anonymous_section = mock(:name => nil)
    
    CSSDoc::Section.stubs(:new)
    document = CSSDoc::Document.new('something.css')
    document.sections = [named_section, anonymous_section]
    
    assert_equal [named_section], document.named_sections
  end
  
  def test_should_return_empty_document_when_parsing_empty_string
    CSSDoc::DocumentHandler.expects(:new).never
    
    CSSDoc::Document.expects(:new).with('something.css')
    CSSDoc::Document.parse(nil, 'something.css')

    CSSDoc::Document.expects(:new).with('something.css')
    CSSDoc::Document.parse('', 'something.css')
  end
end
