module CSSDoc
  class SelectorIndexTemplate < Template
    def initialize(collection)
      @collection = collection
    end

    def template_name
      'selector_index'
    end
    
    def title
      "Selector Index"
    end
  end
end
