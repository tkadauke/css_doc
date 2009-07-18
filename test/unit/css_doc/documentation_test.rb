require File.dirname(__FILE__) + "/../test_helper"

class CSSDoc::Documentation::SectionTest < Test::Unit::TestCase
  def test_should_simply_join_lines_as_string
    section = CSSDoc::Documentation::Section.new(['hello', 'world'])
    assert_equal "hello\nworld", section.to_s
  end
end

class CSSDoc::Documentation::TextSectionTest < Test::Unit::TestCase
  def test_should_wrap_simple_text_in_paragraph_tags
    section = CSSDoc::Documentation::TextSection.new(['hello', 'world'])
    assert_equal '<p>hello world</p>', section.to_html
  end
  
  def test_should_strip_spaces
    section = CSSDoc::Documentation::TextSection.new(['   hello', ' world  '])
    assert_equal '<p>hello world</p>', section.to_html
  end
  
  def test_should_break_paragraph_on_empty_line
    section = CSSDoc::Documentation::TextSection.new(['hello', 'world', '', 'whats', 'up'])
    assert_equal '<p>hello world</p><p>whats up</p>', section.to_html
  end
  
  def test_should_ignore_additional_empty_lines
    section = CSSDoc::Documentation::TextSection.new(['hello', 'world', '', '', '', 'whats', 'up'])
    assert_equal '<p>hello world</p><p>whats up</p>', section.to_html
  end
end

class CSSDoc::Documentation::CodeSectionTest < Test::Unit::TestCase
  def test_should_wrap_simple_text_in_pre_tags
    section = CSSDoc::Documentation::CodeSection.new(['some code', 'here'])
    assert_equal %{<pre>some code\nhere</pre><div class="example">some code\nhere</div>}, section.to_html
  end
  
  def test_should_not_strip_spaces
    section = CSSDoc::Documentation::CodeSection.new(['some code  ', '  here'])
    assert_equal %{<pre>some code  \n  here</pre><div class="example">some code  \n  here</div>}, section.to_html
  end
  
  def test_should_escape_html_characters
    section = CSSDoc::Documentation::CodeSection.new(['<a href="#">Top</a>'])
    assert_equal %{<pre>&lt;a href=&quot;#&quot;&gt;Top&lt;/a&gt;</pre><div class="example"><a href="#">Top</a></div>}, section.to_html
  end
end

class CSSDoc::Documentation::SectionsTest < Test::Unit::TestCase
  def test_should_convert_elements_to_html
    sections = CSSDoc::Documentation::Sections.new([mock(:to_html), mock(:to_html), mock(:to_html)])
    sections.to_html
  end
end

class CSSDoc::DocumentationTest < Test::Unit::TestCase
  class TestDocumentation < CSSDoc::Documentation
    attr_accessor :test, :foo
    
    def parse(lines)
      lines.each do |line|
        parse_one_liners(line)
      end
    end
    
    def one_liners
      ['test', 'foo']
    end
  end
  
  def test_should_raise_exception_when_initialized
    assert_raise NotImplementedError do
      CSSDoc::Documentation.new('/** some comment */')
    end
  end
  
  def test_should_return_original_comment_as_string
    documentation = TestDocumentation.new('/** some comment */')
    assert_equal '/** some comment */', documentation.to_s
  end
  
  def test_should_parse_one_liners
    assert_equal 'hello', TestDocumentation.new('@test hello').test
    assert_equal 'hello', TestDocumentation.new("whats up \n* @test hello").test
    assert_equal 'bar', TestDocumentation.new("whats up \n* @test hello\n@foo bar").foo
    assert_equal '', TestDocumentation.new("whats up \n* @test").test
  end
  
  def test_should_find_out_if_documentation_is_empty?
    assert TestDocumentation.new('').empty?
    assert TestDocumentation.new('  ').empty?
    assert TestDocumentation.new("\n").empty?
    assert TestDocumentation.new('*').empty?
    assert TestDocumentation.new("   *\n\n  * \n  \n * ").empty?
    assert ! TestDocumentation.new("hello").empty?
    assert ! TestDocumentation.new("* hello").empty?
    assert ! TestDocumentation.new("* *").empty?
  end
end
