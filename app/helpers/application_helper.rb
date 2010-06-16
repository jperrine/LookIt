# Methods added to this helper will be available to all templates in the application.
module ApplicationHelper
  
  include TagsHelper
  
  def scrub(text)
    allowed_tags = %w(div span object h1 h2 h3 h4 h5 h6 p blockquote pre a abbr acronym address big cite code )
    allowed_tags += %w(del dfn em img ins kbd q samp small strike strong sub sup tt var b u i )
    allowed_tags += %w(dl dt dd ol ul li legend label table caption tbody tfoot thead tr th td )
    sanitize text, :tags => allowed_tags, :attributes => %w() 
  end
  
end
