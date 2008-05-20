require 'RedCloth'
require 'coderay'

desc 'Transforma o arquivo em HTML'
task :textilize do
  if File.exists?('output/full_book.texttile')
    output = File.new('output/full_book.texttile').read
    output = RedCloth.new(output).to_html

    File.open('output/index.html', 'w') do |f|
      f.puts '<html><head><meta http-equiv="Content-type" content="text/html; charset=utf-8"><link rel="stylesheet" href="../layout/coderay.css" type="text/css" media="screen" /></head><body>'
      f.puts output
      f.puts '</body></html>'
    end
  end
end

class RedCloth
  ##
  # Take a block starting with ruby. and add proper tags for styling.
  #
  #   ruby. def blah()
  def textile_ruby(tag, atts, cite, content)
    # %(<pre><code class="ruby">#{content}</pre></code>)
    ret = CodeRay.scan(content, :ruby).html.div
    ret.gsub!('&quot;', '"')
    ret.gsub!('    ', '  ')
    ret.gsub('&gt;', '>')
  end

  ##
  # Standard code block.
  #
  #   code. git-svn clone foo
  def textile_code(tag, atts, cite, content)
    %(<pre><code>#{content}</pre></code>)
  end
end
