require 'erb'

module CSSDoc
  class Template
    @@default_template_path = File.dirname(__FILE__) + '/../templates/default'
    
    def initialize(options = {})
      @options = options
    end
    
    class Evaluator
      
    end

    def render(name, variables = {})
      variables.each do |key, value|
        instance_variable_set(:"@#{key}", value)
      end
      content = ERB.new(template(name)).result(binding)
      ERB.new(layout).result(binding)
    end
    
    def title
      
    end
    
    def template_path
      @options[:template_path] || @@default_template_path
    end
    
    def template(template_name)
      File.read("#{template_path}/#{template_name}.html.erb")
    end
    
    def layout
      File.read("#{template_path}/layout.html.erb")
    end
    
    def relative_root
      @options[:relative_root] || "."
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
