require File.dirname(__FILE__) + "/../test_helper"

class CSSDoc::SectionTest < Test::Unit::TestCase
  def test_should_generate_documentation_on_initialization
    CSSDoc::SectionDocumentation.expects('new').with('/** CSS comment */')
    CSSDoc::Section.new(mock, '/** CSS comment */')
  end
  
  def test_should_get_section_name_from_documentation
    CSSDoc::SectionDocumentation.stubs('new').returns(mock(:section => 'section name'))
    section = CSSDoc::Section.new(mock, '/** CSS comment */')
    assert_equal 'section name', section.name
  end
end
