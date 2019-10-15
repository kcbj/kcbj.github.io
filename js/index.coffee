---
---
L.mapbox.accessToken = 'pk.eyJ1Ijoia2NiaiIsImEiOiJjazFyd3F2eWMwOTNhM2JwZnc1YXc4MGdyIn0.fzRElIZstlAmU1wizqzvwA';

$( document ).ready ->
  map = L.mapbox.map 'map', 'mapbox.streets', 
    scrollWheelZoom: false
    maxZoom: 15
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

    popup = L.popup( { 'closeButton': false } ).setLatLng( location )
    .setContent( "<b>" + $( this ).data( 'location-name' ) + "</b><br>"  + $( this ).data( 'location-notes' )  + "<br><br>"  + $( this ).data( 'location-address' ) + "<br><a href='https://www.google.com/maps/dir/?api=1&destination=" + $( this ).data( 'location-coordinates' ) + "' target='_blank'>Route</a>")
    marker.bindPopup( popup )
    marker.on 'click', -> this.openPopup()
    $( this ).click -> marker.openPopup()
    locations.push( location )

  bbox = L.latLngBounds locations
  map.fitBounds bbox
