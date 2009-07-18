module CSSDoc
  class DocumentCollection < CSSPool::CSS::Document
    attr_accessor :documents
    
    def initialize
      @documents = []
    end
    
    def rule_sets
      documents.collect { |document| document.rule_sets }.flatten
    end
    
    def selectors
      rule_sets.collect { |rule_set| rule_set.selectors }.flatten
    end
    
    def sections
      documents.collect { |document| document.sections }.flatten
    end
    
    def named_sections
      sections.reject { |section| section.name.nil? }
    end
    
    def selector_hash
      selectors.inject({}) { |hash, selector| (hash[selector.to_css] ||= []) << selector; hash }
    end
    
    def section_hash
      named_sections.inject({}) { |hash, section| (hash[section.name] ||= []) << section; hash }
    end
  end
end
