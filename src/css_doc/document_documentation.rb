module CSSDoc
  class DocumentDocumentation < Documentation
    attr_accessor :file, :note, :appdef, :link, :copyright, :author, :css_for, :version
  
    def parse(lines)
      section_text = []
      lines.each do |line|
        unless parse_one_liners(line)
          section_text << line
        end
      end
      sections << TextSection.new(section_text)
    end
    
    def one_liners
      ['file', 'note', 'appdef', 'link', 'copyright', 'author', 'css-for', 'version']
    end
  end
end
