require File.dirname(__FILE__) + "/../test_helper"

class CSSDoc::FileIndexTemplateTest < Test::Unit::TestCase
  def test_should_render_file_index_template
    template = CSSDoc::IndexTemplate.new(:project_name => 'my_project')
    
    result = template.render
    assert result =~ /my_project/
  end
end
