module CSSDoc
  class DocumentTemplate < Template
    def initialize(document)
      @document = document
    end

    def template_name
      'document'
    end
    
    def title
      @document.name
    end
    
    def relative_root
      (['..'] * File.dirname(@document.name).split('/').size).join('/')
    end
  end
end
