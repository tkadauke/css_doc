require File.dirname(__FILE__) + "/../test_helper"

class CSSDoc::RuleSetTest < Test::Unit::TestCase
  def test_should_return_selector_css
    selectors = [mock(:to_css => 'img'), mock(:to_css => 'a.big')]
    rule_set = CSSDoc::RuleSet.new([])
    rule_set.selectors = selectors
    assert_equal 'img, a.big', rule_set.selector_css
    # no error: result is memoized
    assert_equal 'img, a.big', rule_set.selector_css
  end

  def test_should_return_declaration_css
    declarations = [mock(:to_css => 'display: block;'), mock(:to_css => 'color: blue;')]
    rule_set = CSSDoc::RuleSet.new([])
    rule_set.declarations = declarations
    assert_equal 'display: block; color: blue;', rule_set.declaration_css
    # no error: result is memoized
    assert_equal 'display: block; color: blue;', rule_set.declaration_css
  end
end
