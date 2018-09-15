###
# Page options, layouts, aliases and proxies
###

# Per-page layout changes:
#
# With no layout
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page "/path/to/file.html", layout: :otherlayout

# Proxy pages (http://middlemanapp.com/basics/dynamic-pages/)
# proxy "/this-page-has-no-template.html", "/template-file.html", locals: {
#  which_fake_page: "Rendering a fake page with a local variable" }

###
# Helpers
###

activate :blog do |blog|
  # This will add a prefix to all links, template references and source paths
  blog.prefix = "news"
  
  # blog.permalink = "{year}/{month}/{day}/{title}.html"
  # Matcher for blog source files
  # blog.sources = "{year}-{month}-{day}-{title}.html"
  # blog.taglink = "tags/{tag}.html"
  # blog.layout = "news_layout"
  # blog.summary_separator = /(READMORE)/
  # blog.summary_length = 250
  # blog.year_link = "{year}.html"
  # blog.month_link = "{year}/{month}.html"
  # blog.day_link = "{year}/{month}/{day}.html"
  # blog.default_extension = ".markdown"

  blog.tag_template = "tag.html"
  blog.calendar_template = "calendar.html"

  # Enable pagination
  # blog.paginate = true
  # blog.per_page = 10
  # blog.page_link = "page/{num}"
end

activate :directory_indexes

page "/feed.xml", layout: false
# Reload the browser automatically whenever files change
# configure :development do
#   activate :livereload
# end

require 'date'

# Methods defined in the helpers block are available in templates
 helpers do
   def get_next_event(chapter)
     today = Date.today()
     events = chapter.events.select { |event| event.end_date >= today.strftime('%Y-%m-%d') }
     if events.length
       return events[0]
     end
     return nil
   end
   
   def get_previous_events(chapter)
     today = Date.today()
   	 prev_events = chapter.events.select { |event| event.start_date < today.strftime('%Y-%m-%d') }
   	 prev_events.sort_by { |event| event.start_date || '1970-01-01' }
   	 return prev_events
   end
   
   def get_previous_chapters()
     prev_chapters = data.chapters.select { |key, chapter| get_previous_events(chapter).length > 0 || false }
   end
   
 end

# Build-specific configuration
configure :build do
  # Minify CSS on build
  activate :minify_css

  # Minify Javascript on build
  # activate :minify_javascript
end
