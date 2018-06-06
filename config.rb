# Activate and configure extensions
# https://middlemanapp.com/advanced/configuration/#configuring-extensions

activate :autoprefixer do |prefix|
  prefix.browsers = "last 2 versions"
end

Fog.credentials = { :path_style => true }

activate :livereload

activate :dotenv

activate :directory_indexes

activate :i18n, langs: [:en, :fr], mount_at_root: :en, path: '/:locale/'

activate :s3_sync do |config|
  config.bucket = 'sjacobsen.com'
  config.region = 'us-east-2'
  config.aws_access_key_id = ENV['AWS_ACCESS_KEY']
  config.aws_secret_access_key = ENV['AWS_ACCESS_SECRET']
  config.after_build = false
end

# Layouts
# https://middlemanapp.com/basics/layouts/

# Per-page layout changes
page '/*.xml', layout: false
page '/*.json', layout: false
page '/*.txt', layout: false

# With alternative layout
# page '/path/to/file.html', layout: 'other_layout'

# Proxy pages
# https://middlemanapp.com/advanced/dynamic-pages/

# proxy(
#   '/this-page-has-no-template.html',
#   '/template-file.html',
#   locals: {
#     which_fake_page: 'Rendering a fake page with a local variable'
#   },
# )

# Helpers
# Methods defined in the helpers block are available in templates
# https://middlemanapp.com/basics/helper-methods/

helpers do
  def determine_language_header(lang)
    if lang === :fr
      return "<div><a href=\"/\">Hello</a></div> <div class=\"hero__intro--selected-language\"><a href=\"fr\">Bonjour</a></div>"
    else
      return "<div class=\"hero__intro--selected-language\"><a href=\"/\">Hello</a></div> <div><a href=\"fr\">Bonjour</a></div>"
    end
  end
end

# Build-specific configuration
# https://middlemanapp.com/advanced/configuration/#environment-specific-settings

configure :build do
  activate :minify_css
  activate :minify_javascript
  activate :gzip
end
