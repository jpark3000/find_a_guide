
$(document).ready(function() {
	var bounds;
  var input = (document.getElementById('pac-input'));
  var searchBox = new google.maps.places.SearchBox(input);

  google.maps.event.addListener(searchBox, 'places_changed', function() {
  	var places = searchBox.getPlaces();
  	$.each(places, function(i, place) {
  		bounds = place.geometry.viewport;
  	});
  	$('#initial_bounds').val(bounds.toString());
  });

});