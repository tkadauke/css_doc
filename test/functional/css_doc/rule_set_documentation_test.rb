require File.dirname(__FILE__) + "/../test_helper"

class CSSDoc::RuleSetDocumentationTest < Test::Unit::TestCase
  def test_should_parse_one_liners
    comment = <<-end
      * @name Cool rule set
      * @formerly Really cool rule set
      * @deprecated true
    end
    documentation = CSSDoc::RuleSetDocumentation.new(comment)
    assert_equal 'Cool rule set', documentation.name
    assert_equal 'Really cool rule set', documentation.formerly
    assert_equal 'true', documentation.deprecated
  end
  
  def test_should_add_description_tag_to_text_section
    comment = <<-end
      * @name Cool rule set
      * @description This is a
      * good rule set
    end
    documentation = CSSDoc::RuleSetDocumentation.new(comment)
    assert_equal 'Cool rule set', documentation.name
    assert_equal '<p>This is a good rule set</p>', documentation.sections.first.to_html
  end

  def test_should_parse_sections
    comment = <<-end
      * This is a good rule set.
      *
      * @code
      *   This code proves it.
      * @endcode
      *
      * It is still good.
    end
    documentation = CSSDoc::RuleSetDocumentation.new(comment)
    assert_equal '<p>This is a good rule set.</p>', documentation.sections[0].to_html
    assert_equal "<pre>   This code proves it.</pre><div class=\"example\">   This code proves it.</div>", documentation.sections[1].to_html
    assert_equal '<p>It is still good.</p>', documentation.sections[2].to_html
  end
end
