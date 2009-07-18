require 'erb'

module CSSDoc
  class Template
    @@template_path = File.dirname(__FILE__) + '/../templates/default'
    
    def initialize
    end

    def render
      content = ERB.new(template).result(binding)
      ERB.new(layout).result(binding)
    end
    
    def title
      
    end
    
    def template
      File.read("#{@@template_path}/#{template_name}.html.erb")
    end
    
    def layout
      File.read("#{@@template_path}/layout.html.erb")
    end
    
    def relative_root
      "."
    end
    
    def truncate(string, length)
      if string.size > length
        string[0..(length - 4)] + '...'
      else
        string
      end
    end
  end
end
