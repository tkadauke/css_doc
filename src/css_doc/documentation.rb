module CSSDoc
  class Documentation
    class Section
      attr_accessor :lines
      def initialize(lines)
        self.lines = lines
      end

      def to_s
        lines.join("\n")
      end
    end
    
    class TextSection < Section
      def to_html
        result = "<p>"
        result << lines.collect {|l|l.strip}.join("\n").gsub(/\n\n+/, '</p><p>').gsub(/\n/, ' ').strip
        result << "</p>"
        result.gsub('<p></p>', '')
      end
    end
      
    class CodeSection < Section
      def to_html
        result = "<pre>" + lines.join("\n").gsub("<", "&lt;").gsub(">", "&gt;").gsub('"', '&quot;') + "</pre>"
        result << %{<div class="example">#{lines.join("\n")}</div>}
      end
    end
    
    class Sections < Array
      def to_html
        collect {|section| section.to_html}
      end
    end

    attr_accessor :comment
    attr_accessor :sections
    
    def self.tags
      @tags ||= []
    end
    
    def self.define_tag(*names)
      names.each do |name|
        attr_accessor name
        tags << name
      end
    end
    
    def initialize(comment)
      @comment = comment
      @sections = Sections.new
      parse_documentation
    end
    
    def to_s
      @comment
    end
    
    def parse_tags(line)
      self.class.tags.each do |tag|
        rx = /@#{tag.to_s.gsub('_', '-')}/
        if line =~ rx
          instance_variable_set(:"@#{tag}", line.gsub(rx, "").strip)
          return true
        end
      end
      return false
    end
    
    def parse_comment
      @parsed_comment ||= comment.gsub(/\*\/$/, '').split("\n").collect { |line| line.gsub(/^\s*\*/, '') }
    end
    
    def parse_documentation
      lines = parse_comment
      parse(lines)
    end
    
    def empty?
      parse_comment.join("\n").strip.empty?
    end
  
    def parse(lines)
      section_type = TextSection
      section_text = []
      lines.each do |line|
        unless parse_tags(line)
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
      
      sections.each do |section|
        Examples.add(section) if section.is_a?(CodeSection)
      end
    end
  end
end