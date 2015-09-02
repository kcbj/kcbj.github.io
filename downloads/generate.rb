#!/usr/bin/env ruby

require 'YAML'
require 'filesize'
require 'mime/types'

downloads = Dir[ 'files/*' ].map do |dir|
  description = YAML::load_file( dir + "/description.yml" )
  description[ 'path' ] = '/downloads/' + dir

  description[ 'files' ] = Dir[ dir + "/*" ].map do |file|
    next if File.basename( file ) == 'description.yml'

    file_description = ( description[ 'files' ].nil? ? nil : description[ 'files' ].first { |desc| desc[ 'path' ] == File.basename( file ) } ) || {}
    file_description = file_description.merge( { 'path' => '/downloads/' + file, 'size' => File.size( file ) } )

    file_description[ 'title' ] ||= File.basename( file ).gsub( /\.[a-z]+$/, '' ).gsub( /[^a-z]/i, ' ' ).capitalize
    file_description[ 'hsize' ] = Filesize.from( file_description[ 'size' ].to_s + ' B' ).pretty
    file_description[ 'mime' ] = MIME::Types.of( file ).first.sub_type

    file_description
  end

  description[ 'files' ].compact!
  description
end

puts downloads.to_yaml
