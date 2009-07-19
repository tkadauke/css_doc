module CSSDoc
  class SectionIndexTemplate < Template
    def initialize(collection, options = {})
      super(options)
      @collection = collection
    end

    def template_name
      'section_index'
    end
    
    def title
      "Section Index"
    end
  end
end
