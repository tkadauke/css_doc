module CSSDoc
  class FileIndexTemplate < Template
    def initialize(collection)
      @collection = collection
    end

    def template_name
      'file_index'
    end
    
    def title
      "File Index"
    end
  end
end
