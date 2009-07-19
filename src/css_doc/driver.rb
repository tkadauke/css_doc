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
        
        relative_root = '.'
        relative_root = (['..'] * File.dirname(doc.name).split('/').size).join('/') if doc.name =~ /\//

        html = CSSDoc::Template.new(@options.merge(:relative_root => relative_root)).render('document', :document => doc, :title => doc.name)
        File.open("#{@options[:output_dir]}/#{doc.output_file_name}", 'w') { |file| file.puts html }

        @collection.documents << doc
      end
    end
    
    def generate_index_documentation
      log "Generating Selector Index ..."

      html = CSSDoc::Template.new(@options).render('selector_index', :collection => @collection, :title => 'Selector Index')
      File.open("#{@options[:output_dir]}/selector_index.html", 'w') { |file| file.puts html }

      log "Generating File Index ..."

      html = CSSDoc::Template.new(@options).render('file_index', :collection => @collection, :title => 'File Index')
      File.open("#{@options[:output_dir]}/file_index.html", 'w') { |file| file.puts html }

      log "Generating Section Index ..."

      html = CSSDoc::Template.new(@options).render('section_index', :collection => @collection, :title => 'Section Index')
      File.open("#{@options[:output_dir]}/section_index.html", 'w') { |file| file.puts html }

      log "Generating Index Page ..."

      html = CSSDoc::Template.new(@options).render('index', :project_name => @options[:project_name], :title => 'Index')
      File.open("#{@options[:output_dir]}/index.html", 'w') { |file| file.puts html }
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
  end
end
