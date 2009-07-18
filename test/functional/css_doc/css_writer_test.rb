require File.dirname(__FILE__) + "/../test_helper"

class CSSDoc::CSSWriterTest < Test::Unit::TestCase
  def setup
    @collection = CSSDoc::DocumentCollection.new
  end
  
  def test_should_add_example_class_before_each_selector
    @collection.documents << CSSDoc::Document.parse('img { width: 100%; } a.hidden { display:none; }', 'something.css')
    writer = CSSDoc::CSSWriter.new(@collection)
    assert_equal "div.example img{  width: 100.0%;}\ndiv.example a.hidden{  display: none;}\n", writer.write
  end
  
  def test_should_join_documents_together
    @collection.documents << CSSDoc::Document.parse('img { width: 100%; }', 'something.css')
    @collection.documents << CSSDoc::Document.parse('a.hidden { display:none; }', 'something_else.css')
    writer = CSSDoc::CSSWriter.new(@collection)
    assert_equal "div.example img{  width: 100.0%;}\ndiv.example a.hidden{  display: none;}\n", writer.write
  end
end
