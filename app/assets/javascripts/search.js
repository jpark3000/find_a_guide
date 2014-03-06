
$(document).ready(function() {
  var input = (document.getElementById('pac-input'));
  var searchBox = new google.maps.places.SearchBox(input);

  $('#search_form').on('submit', function(e) {
    e.preventDefault();
  });

  google.maps.event.addListener(searchBox, 'places_changed', function() {
    var place = searchBox.getPlaces()[0];
    var bounds = place.geometry.viewport;
    $('#initial_bounds').val(bounds.toString());

    $('#search_form').unbind('submit');
  });
});
