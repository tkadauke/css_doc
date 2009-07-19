module CSSDoc
  class Driver
    def run(options = {})
      @options = options
      
      @collection = CSSDoc::DocumentCollection.new

      generate_file_documentation
      generate_index_documentation
      generate_css
      copy_additional_files
    end
    
    def generate_file_documentation
      skip_files = @options[:skip_files] || []
      
      Dir.glob("#{@options[:input_dir]}/**/*.css").each do |file_name|
        relative_path = file_name.gsub("#{@options[:input_dir]}/", '')
        next if skip_files.include?(relative_path)
        
        log "Generating documentation for file #{relative_path} ..."

        FileUtils.mkdir_p("#{@options[:output_dir]}/#{File.dirname(relative_path)}")
        doc = CSSDoc::Document.parse(File.read(file_name), relative_path)
        
        generate(:template => 'document', :file_name => doc.output_file_name, :locals => { :document => doc, :title => doc.name })

        @collection.documents << doc
      end
    end
    
    def generate_index_documentation
      log "Generating Selector Index ..."
      
      generate(:template => 'selector_index', :locals => { :collection => @collection, :title => 'Selector Index' })

      log "Generating File Index ..."

      generate(:template => 'file_index', :locals => { :collection => @collection, :title => 'File Index' })

      log "Generating Section Index ..."

      generate(:template => 'section_index', :locals => { :collection => @collection, :title => 'Section Index' })

      log "Generating Index Page ..."

      generate(:template => 'index', :locals => { :project_name => @options[:project_name], :title => 'Index' })
    end
    
    def generate_css
      log "Generating Example CSS ..."

      writer = CSSDoc::CSSWriter.new(@collection)
      File.open("#{@options[:output_dir]}/styles.css", 'w') { |file| file.puts writer.write }
    end
    
    def copy_additional_files
      log "Copying Additional Files ..."

      FileUtils.cp("#{@options[:template_path]}/css_doc.css", "#{@options[:output_dir]}/")
    end
    
    def log(string)
      puts string if @options[:verbose]
    end
    
  private
    def generate(params)
      file_name = params[:file_name] || params[:template]
      
      relative_root = '.'
      relative_root = (['..'] * File.dirname(file_name).split('/').size).join('/') if file_name =~ /\//

      html = CSSDoc::Template.new(@options).render(params[:template], params[:locals])
      File.open("#{@options[:output_dir]}/#{file_name}.html", 'w') { |file| file.puts html }
    end
  end
end
