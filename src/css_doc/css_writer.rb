module CSSDoc
  class CSSWriter
    def initialize(collection)
      @collection = collection
    end
    
    def write
      output = ""
      @collection.rule_sets.each do |rule_set|
        selectors = rule_set.selectors.collect { |selector| 'div.example ' + selector.to_css }
        output << selectors.join(', ')
        output << '{'
        output << rule_set.declaration_css
        output << '}'
        output << "\n"
      end
      output
    end
  end
end
