module CSSDoc
  class Section
    attr_accessor :document
    attr_accessor :rule_sets
    attr_accessor :documentation
    
    def initialize(document, comment)
      @document = document
      @rule_sets = []
      @documentation = SectionDocumentation.new(comment)
    end
    
    def name
      documentation.section
    end
  end
end
