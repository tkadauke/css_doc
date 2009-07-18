module CSSPool
  module Visitors
    class ToCSS
      def visit_CSSDoc_RuleSet(*args)
        visit_CSSPool_CSS_RuleSet(*args)
      end
    end
  end
end
