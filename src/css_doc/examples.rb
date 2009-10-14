module CSSDoc
  class Examples
    def self.add(code)
      @examples ||= []
      @examples << code
    end
    
    def self.all
      @examples
    end
  end
end
