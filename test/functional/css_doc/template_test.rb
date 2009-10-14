require File.dirname(__FILE__) + "/../test_helper"

class CSSDoc::TemplateTest < Test::Unit::TestCase
  [:default, :simple].each do |template|
    define_method "test_should_render_document_template_with_#{template}_template" do
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
      result = CSSDoc::Template.new.render('document', :document => document, :template_path => template.to_s)
      assert result =~ /This file is awesome/
      assert result =~ /John Doe/
      assert result =~ /width: 100.0%/
      assert result =~ /display: none/
    end

    define_method "test_should_render_file_index_template_with_#{template}_template" do
      css1 = "img { width: 100%; }"
      css2 = "a { display: none; }"

      collection = CSSDoc::DocumentCollection.new
      collection.documents << CSSDoc::Document.parse(css1, 'something.css')
      collection.documents << CSSDoc::Document.parse(css2, 'something_else.css')
    
      result = CSSDoc::Template.new.render('file_index', :collection => collection, :template_path => template.to_s)
    
      assert result =~ /something.css/
      assert result =~ /something_else.css/
    end

    define_method "test_should_render_index_template_with_#{template}_template" do
      result = CSSDoc::Template.new.render('index', :project_name => 'my_project', :template_path => template.to_s)
    
      assert result =~ /my_project/
    end

    define_method "test_should_render_section_index_template_with_#{template}_template" do
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
    
      result = CSSDoc::Template.new.render('section_index', :collection => collection, :template_path => template.to_s)
    
      assert result =~ /Images/
      assert result =~ /Links/
    end

    define_method "test_should_render_selector_index_template_with_#{template}_template" do
      css1 = "img { width: 100%; }"
      css2 = "a.big { display: none; }"

      collection = CSSDoc::DocumentCollection.new
      collection.documents << CSSDoc::Document.parse(css1, 'something.css')
      collection.documents << CSSDoc::Document.parse(css2, 'something_else.css')
    
      result = CSSDoc::Template.new.render('selector_index', :collection => collection, :template_path => template.to_s)
    
      assert result =~ /img/
      assert result =~ /a.big/
    end

    define_method "test_should_render_example_index_template_with_#{template}_template" do
      css = <<-end
        /**
        * @code
        * <img src="example" />
        * @endcode
        */
        img { width: 100%; }
      end

      collection = CSSDoc::DocumentCollection.new
      collection.documents << CSSDoc::Document.parse(css, 'something.css')
    
      result = CSSDoc::Template.new.render('example_index', :collection => collection, :template_path => template.to_s)
    
      assert result =~ /img src="example"/
    end
  end
end
