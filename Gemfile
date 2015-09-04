source 'https://rubygems.org'

# GitHub Pages gem
require 'json'
require 'open-uri'
versions = JSON.parse( open( 'https://pages.github.com/versions.json' ).read )

gem 'jekyll', versions[ 'jekyll' ]
gem 'github-pages', versions[ 'github-pages' ]
gem 'jekyll-sitemap', versions[ 'jekyll-sitemap' ]
gem 'jekyll-feed', versions[ 'jekyll-feed' ]

# Bourbon
gem 'bourbon', '~> 4.2.3'

gem 'filesize'
gem 'mime-types'
