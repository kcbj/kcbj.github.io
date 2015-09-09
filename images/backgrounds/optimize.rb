#!/usr/bin/env ruby

sizes = {
  'mobile' => 760,
  'mobile@2x' => 1520,
  'large' => 1520,
  'large@2x' => 2560
}

options = "-strip -interlace Plane -quality 86"

Dir[ "./originals/*.jpg" ].each do |file|
  basename = File.basename( file, '.jpg' )
  sizes.each do |id,size|
    target = basename + '-' + id + ".jpg"
    puts "#{file.rjust( 40, ' ' )} -> #{target} (#{size}x#{size})"
    `convert #{file} #{options} -resize #{size}x#{size}\\> #{target}`
  end

  target = basename + '-orig.jpg'
  puts "#{file.rjust( 40, ' ' )} -> #{target} (original)"
  `convert #{file} #{options} #{target}`
end
