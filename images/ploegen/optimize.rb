#!/usr/bin/env ruby

size = 760
options = "-strip -interlace Plane -quality 86"

Dir[ '**/*.jpg' ].each do |file|
  basename = File.basename( file, '.jpg' )
  folder = File.dirname( file )
  target = folder + "/" + basename + ".jpg"
  puts "#{file.rjust( 40, ' ' )} -> #{target} (#{size}x#{size})"
  `convert #{file} #{options} -resize #{size}x#{size}\\> #{target}`
end
