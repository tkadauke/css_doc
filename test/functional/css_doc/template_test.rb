require File.dirname(__FILE__) + "/../test_helper"

class CSSDoc::TemplateTest < Test::Unit::TestCase
  def test_should_render_document_template
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
    result = CSSDoc::Template.new.render('document', :document => document)
    assert result =~ /This file is awesome/
    assert result =~ /John Doe/
    assert result =~ /width: 100.0%/
    assert result =~ /display: none/
  end

  def test_should_render_file_index_template
    css1 = "img { width: 100%; }"
    css2 = "a { display: none; }"

    collection = CSSDoc::DocumentCollection.new
    collection.documents << CSSDoc::Document.parse(css1, 'something.css')
    collection.documents << CSSDoc::Document.parse(css2, 'something_else.css')
    
    result = CSSDoc::Template.new.render('file_index', :collection => collection)
    
    assert result =~ /something.css/
    assert result =~ /something_else.css/
  end

  def test_should_render_index_template
    result = CSSDoc::Template.new.render('index', :project_name => 'my_project')
    
    assert result =~ /my_project/
  end

  def test_should_render_section_index_template
    css1 = <<-end
      /**
      * @section Images
      */
      img { width: 100%; }
    end

    css2 = <<-end
      /**
      * @section Links
      */
      a { display: none; }
    end

    collection = CSSDoc::DocumentCollection.new
    collection.documents << CSSDoc::Document.parse(css1, 'something.css')
    collection.documents << CSSDoc::Document.parse(css2, 'something_else.css')
    
    result = CSSDoc::Template.new.render('section_index', :collection => collection)
    
    assert result =~ /Images/
    assert result =~ /Links/
  end

  def test_should_render_selector_index_template
    css1 = "img { width: 100%; }"
    css2 = "a.big { display: none; }"

    collection = CSSDoc::DocumentCollection.new
    collection.documents << CSSDoc::Document.parse(css1, 'something.css')
    collection.documents << CSSDoc::Document.parse(css2, 'something_else.css')
    
    result = CSSDoc::Template.new.render('selector_index', :collection => collection)
    
    assert result =~ /img/
    assert result =~ /a.big/
  end
end
