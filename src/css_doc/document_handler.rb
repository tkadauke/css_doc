module CSSDoc
  class DocumentHandler < CSSPool::CSS::DocumentHandler
    def initialize(name)
      super()
      @name = name
    end
    
    def start_document
      @document = CSSDoc::Document.new(@name)
    end

    def comment(comment)
      if comment =~ /@file|@note/
        @document.documentation = DocumentDocumentation.new(comment)
      elsif comment =~ /@section/
        @document.sections << Section.new(@document, comment)
      else
        @last_comment = comment
      end
    end

    def start_selector(selector_list)
      rule_set = CSSDoc::RuleSet.new(
        selector_list,
        [],
        @media_stack.last || []
      )
      rule_set.document = @document
      rule_set.documentation = RuleSetDocumentation.new(@last_comment =~ /^\*/ ? @last_comment : "")
      @last_comment = nil
    
      @document.rule_sets << rule_set
      @document.sections.last.rule_sets << rule_set
    end
  end
end
