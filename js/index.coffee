---
---
L.mapbox.accessToken = 'pk.eyJ1IjoicnV0Z2VyY2xhZXMiLCJhIjoiWHB3ZHNKYyJ9.5Scj6OBiQoNCKMwWOWkYuw';

$( document ).ready ->
  map = L.mapbox.map 'map', 'mapbox.streets', 
    scrollWheelZoom: false
    maxZoom: 16
  locations = []

  $( '#location-list *[data-location-coordinates]' ).each (i) ->
    location = L.latLng( $( this ).data( 'location-coordinates' ).split( ',' ) )
    marker = L.marker location,
      icon: L.mapbox.marker.icon
        'marker-size': 'large',
        'marker-symbol': i + 1,
        'marker-color': '#006699'
    .addTo map

    $( this ).css 
      'background-image': 'url( "' + marker.options.icon.options.iconUrl + '")'
      'cursor': 'pointer'

    popup = L.popup( { 'closeButton': false } ).setLatLng( location ).setContent( $( this ).data( 'location-name' ) )
    marker.bindPopup( popup )
    marker.on 'click', -> this.openPopup()
    $( this ).click -> marker.openPopup()
    locations.push( location )

  bbox = L.latLngBounds locations
  map.fitBounds bbox
