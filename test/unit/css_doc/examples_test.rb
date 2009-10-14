require File.dirname(__FILE__) + "/../test_helper"

class CSSDoc::ExamplesTest < Test::Unit::TestCase
  def test_should_add_example
    example = stub
    CSSDoc::Examples.add(example)
    assert_equal [example], CSSDoc::Examples.all
  end
end
