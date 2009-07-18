module CSSDoc
  class RuleSetDocumentation < Documentation
    attr_accessor :name, :formerly, :deprecated
  
    def parse(lines)
      section_type = TextSection
      section_text = []
      lines.each do |line|
        unless parse_one_liners(line)
          if line =~ /@code/
            sections << section_type.new(section_text)
            section_text = []
            section_type = CodeSection
          elsif line =~ /@endcode/
            sections << section_type.new(section_text)
            section_text = []
            section_type = TextSection
          elsif line =~ /@description/
            section_text << line.gsub(/@description/, '')
          else
            section_text << line
          end
        end
      end
      sections << section_type.new(section_text)
    end
    
    def one_liners
      ['name', 'formerly', 'deprecated']
    end
  end
end
