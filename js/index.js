$( document ).ready(function() {
  var map = new mapboxgl.Map({
    container: 'map',
    style:  'mapbox://styles/mapbox/streets-v9',
    scrollWheelZoom: false,
    maxZoom: 14
  })
  var bounds = new mapboxgl.LngLatBounds()

  $("#location-list *[data-location-coordinates]").each(function(i) {
    var location =  $(this).data("location-coordinates").split(",").reverse();

    var popup = new mapboxgl.Popup().setHTML(
        "<b>" + $(this).data("location-name") + "</b><br>"  + $(this).data("location-notes") + "<br>"  + $(this).data("location-address") + "<br><a href='https://www.google.com/maps/dir/?api=1&destination=" + $(this).data("location-coordinates") + "' target='_blank'>Route</a>"
    );

    var marker = new mapboxgl.Marker()
        .setLngLat(location)
        .setPopup(popup)
        .addTo(map);
    bounds.extend(location);
    $(this).click(function() {
        marker.togglePopup();
    });
  })

  map.fitBounds(bounds, {
    animate: false,
    padding: {top: 40, bottom: 40, left: 20, right: 20}
  });
});