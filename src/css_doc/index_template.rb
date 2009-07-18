module CSSDoc
  class IndexTemplate < Template
    def initialize(options)
      @project_name = options[:project_name]
    end
    
    def template_name
      'index'
    end
    
    def title
      "Index"
    end
  end
end
