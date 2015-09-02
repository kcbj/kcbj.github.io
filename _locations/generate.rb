#!/usr/bin/env ruby
require 'yaml'

locations = YAML::load_file( '../_data/locations.yml' )
locations.each_with_index do |location,index|
  data = location.merge( 'order' => index )
  File.open( "#{data['id']}.html", 'w' ) << data.to_yaml + "\n---"
end
