---
---
$( document ).ready () ->
  $( '*[data-map]' ).each () ->
    location = L.latLng $( this ).data( 'lat' ), $( this ).data( 'lng' )
    map = L.mapbox.map 'map', 'mapbox.streets', 
      center: location
      zoom: 15
      scrollWheelZoom: false
      maxZoom: 16
    marker = L.marker location,
      icon: L.mapbox.marker.icon
        'marker-size': 'large'
        'marker-color': '#006699'
    .addTo map
