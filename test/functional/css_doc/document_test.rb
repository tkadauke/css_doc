require File.dirname(__FILE__) + "/../test_helper"

class CSSDoc::DocumentTest < Test::Unit::TestCase
  def setup
  end
  
  def test_should_parse_simple_document
    css = <<-end
      img { width: 100%; }
      a { display: none; }
    end
    document = CSSDoc::Document.parse(css, 'something.css')
    assert_equal 2, document.rule_sets.size
  end
  
  def test_should_parse_file_scope_comment
    css = <<-end
      /**
      * @file something.css
      * This file is awesome
      * @author John Doe
      */
      img { width: 100%; }
      a { display: none; }
    end
    document = CSSDoc::Document.parse(css, 'something.css')
    assert_equal 'something.css', document.documentation.file
    assert_equal 'John Doe', document.documentation.author
    assert_equal '<p>This file is awesome</p>', document.documentation.sections.first.to_html
    assert_equal 2, document.rule_sets.size
    assert_equal 1, document.sections.size
  end
  
  def test_should_parse_section_comment
    css = <<-end
      /**
      * @section Awesome stuff
      *
      * This section is awesome
      */
      img { width: 100%; }
      a { display: none; }
    end
    document = CSSDoc::Document.parse(css, 'something.css')
    
    assert_equal '<p>This section is awesome</p>', document.sections.last.documentation.sections.first.to_html
    assert_equal 'Awesome stuff', document.sections.last.name
    assert_equal 2, document.rule_sets.size
  end
  
  def test_should_parse_rule_set_comment
    css = <<-end
      /**
      * The following rules are good.
      *
      * Example:
      *
      * @code
      *   <a href="#"><img src="/img.png" /></a>
      * @endcode
      *
      * See? Told you.
      */
      img { width: 100%; }
      a { display: none; }
    end
    document = CSSDoc::Document.parse(css, 'something.css')
    assert_equal '<p>The following rules are good.</p><p>Example:</p>', document.rule_sets.first.documentation.sections.first.to_html
    code = "<pre>   &lt;a href=&quot;#&quot;&gt;&lt;img src=&quot;/img.png&quot; /&gt;&lt;/a&gt;</pre><div class=\"example\">   <a href=\"#\"><img src=\"/img.png\" /></a></div>"
    assert_equal code, document.rule_sets.first.documentation.sections[1].to_html
    assert_equal '<p>See? Told you.</p>', document.rule_sets.first.documentation.sections.last.to_html
  end
end
