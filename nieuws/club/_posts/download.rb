#!/usr/bin/env ruby

require 'YAML'

Dir[ "*.html" ].each do |file|
  image = "images/news/" + File.basename( file, '.html' ) + ".jpg"
  content = File.open( file, 'r' ).read.split( '---', 3 )
  front = YAML::load( "---\n" + content[1] )
  dl = front[ 'image' ]
  cmd = "wget --output-document=../#{image} #{dl}"
  `#{cmd}`

  front[ 'image' ] = "/images/news/" + File.basename( file, '.html' ) + ".jpg"
  content = front.to_yaml + "---" + content[2]

  File.open( file, 'w' ) << content
end
