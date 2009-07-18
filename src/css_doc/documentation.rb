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
    
    def initialize(comment)
      @comment = comment
      @sections = Sections.new
      parse_documentation
    end
    
    def to_s
      @comment
    end
    
    def parse_one_liners(line)
      one_liners.each do |one_liner|
        rx = /@#{one_liner}/
        if line =~ rx
          instance_variable_set(:"@#{one_liner.gsub('-', '_')}", line.gsub(rx, "").strip)
          return true
        end
      end
      return false
    end
    
    def one_liners
      []
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
      raise NotImplementedError
    end
  end
end