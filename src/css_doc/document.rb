module CSSDoc
  class Document < CSSPool::CSS::Document
    attr_accessor :documentation
    attr_accessor :sections
    attr_accessor :name
    
    def self.parse string, name
      unless string && string.length > 0
        return CSSDoc::Document.new
      end
      handler = CSSDoc::DocumentHandler.new(name)
      parser = CSSPool::SAC::Parser.new(handler)
      parser.parse(string)
      handler.document
    end
    
    def initialize(name)
      super()
      @name = name
      @sections = [Section.new(self, '')]
    end
    
    def output_file_name
      name.gsub('.css', '_css.html')
    end
    
    def named_sections
      sections.reject {|section| section.name.nil?}
    end
  end
end
