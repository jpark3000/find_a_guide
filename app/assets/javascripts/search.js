
$(document).ready(function() { 
  var input = (document.getElementById('pac-input'));
  var searchBox = new google.maps.places.Autocomplete(input);
  google.maps.event.addListener(searchBox, 'place_changed', function() {
    var place = searchBox.getPlace();
    var bounds = place.geometry.viewport;

    

    $('#initial_bounds').val(bounds.toString());


  });

  
  
});