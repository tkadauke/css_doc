require File.dirname(__FILE__) + "/../test_helper"

class CSSDoc::DocumentCollectionTest < Test::Unit::TestCase
  def test_should_initialize_with_empty_collection
    assert_equal [], CSSDoc::DocumentCollection.new.documents
  end
  
  def test_should_return_rule_sets_from_all_documents
    documents = [mock(:rule_sets => [:a]), mock(:rule_sets => [:b, :c]), mock(:rule_sets => [:d])]
    collection = CSSDoc::DocumentCollection.new
    collection.documents = documents
    assert_equal [:a, :b, :c, :d], collection.rule_sets
  end
  
  def test_should_return_selectors_from_all_documents
    rule_sets = [mock(:selectors => [:a]), mock(:selectors => [:b, :c]), mock(:selectors => [:d])]
    collection = CSSDoc::DocumentCollection.new
    collection.expects(:rule_sets).returns(rule_sets)
    assert_equal [:a, :b, :c, :d], collection.selectors
  end

  def test_should_return_sections_from_all_documents
    documents = [mock(:sections => [:a]), mock(:sections => [:b, :c]), mock(:sections => [:d])]
    collection = CSSDoc::DocumentCollection.new
    collection.documents = documents
    assert_equal [:a, :b, :c, :d], collection.sections
  end
  
  def test_should_return_named_sections_from_all_documents
    hello = mock(:name => 'hello')
    world = mock(:name => 'world')
    sections = [hello, world, mock(:name => nil)]
    collection = CSSDoc::DocumentCollection.new
    collection.expects(:sections).returns(sections)
    assert_equal [hello, world], collection.named_sections
  end

  def test_should_return_selectors_from_all_documents_as_hash_by_selector_css
    first = mock(:to_css => 'a.big')
    second = mock(:to_css => 'img')
    third = mock(:to_css => 'a.big')
    selectors = [first, second, third]
    collection = CSSDoc::DocumentCollection.new
    collection.expects(:selectors).returns(selectors)
    assert_equal({ 'a.big' => [first, third], 'img' => [second] }, collection.selector_hash)
  end

  def test_should_return_selectors_from_all_documents_as_hash_by_selector_css
    first = mock(:name => 'hello')
    second = mock(:name => 'world')
    third = mock(:name => 'hello')
    sections = [first, second, third]
    collection = CSSDoc::DocumentCollection.new
    collection.expects(:named_sections).returns(sections)
    assert_equal({ 'hello' => [first, third], 'world' => [second] }, collection.section_hash)
  end
end
