module CSSDoc
  class SectionDocumentation < Documentation
    attr_accessor :section
  
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
      ['section']
    end
  end
end
