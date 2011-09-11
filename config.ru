# Based on http://stackoverflow.com/questions/3863781/ruby-rack/3930606#3930606
#
# There is also https://github.com/adaoraul/rack-jekyll, but that's an unnecessary
# dependency and doesn't support "MultiViews" (/about finds /about.html).

@root = File.expand_path(File.dirname(__FILE__)) + "/_site"
@e404 = @root + "/404.html"

app = lambda do |env|

  # Injection safe: /../../x will request /x.
  file = @root + Rack::Utils.unescape(env['PATH_INFO'])
  index_file = "#{file}/index.html"
  html_file  = "#{file}.html"

  if File.exists?(index_file)
    [200, {'Content-Type' => 'text/html'}, File.read(index_file)]
  elsif File.exists?(html_file)
    [200, {'Content-Type' => 'text/html'}, File.read(html_file)]
  elsif File.exists?(file)
    Rack::File.new(@root).call(env)
  else
    [404, {'Content-Type' => 'text/html'}, File.read(@e404)]
  end
end

run app
