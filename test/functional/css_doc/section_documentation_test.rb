require File.dirname(__FILE__) + "/../test_helper"

class CSSDoc::SectionDocumentationTest < Test::Unit::TestCase
  def test_should_parse_one_liners
    comment = <<-end
      * @section This is a cool section
    end
    documentation = CSSDoc::SectionDocumentation.new(comment)
    assert_equal 'This is a cool section', documentation.section
  end
  
  def test_should_parse_section
    comment = <<-end
      * @section This is a cool section
      * It is really cool.
    end
    documentation = CSSDoc::SectionDocumentation.new(comment)
    assert_equal 'This is a cool section', documentation.section
    assert_equal '<p>It is really cool.</p>', documentation.sections.first.to_html
  end
end
