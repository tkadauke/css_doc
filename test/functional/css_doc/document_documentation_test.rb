require File.dirname(__FILE__) + "/../test_helper"

class CSSDoc::DocumentDocumentationTest < Test::Unit::TestCase
  def test_should_parse_one_liners
    comment = <<-end
      * @file something.css
      * @note This file is cool
      * @appdef my_app
      * @link http://www.example.com
      * @copyright (2009) me
      * @author John Doe
      * @css-for Good Browsers
      * @version 1.0
    end
    documentation = CSSDoc::DocumentDocumentation.new(comment)
    assert_equal 'something.css', documentation.file
    assert_equal 'This file is cool', documentation.note
    assert_equal 'my_app', documentation.appdef
    assert_equal 'http://www.example.com', documentation.link
    assert_equal '(2009) me', documentation.copyright
    assert_equal 'John Doe', documentation.author
    assert_equal 'Good Browsers', documentation.css_for
    assert_equal '1.0', documentation.version
  end
  
  def test_should_parse_section_text
    comment = <<-end
      * @file something.css
      *
      * This is a good file
    end
    documentation = CSSDoc::DocumentDocumentation.new(comment)
    assert_equal 'something.css', documentation.file
    assert_equal '<p>This is a good file</p>', documentation.sections.first.to_html
  end
end
