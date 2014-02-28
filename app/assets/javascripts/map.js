var tour_description_template = "<div id='tour_desc'>\
                                  <form id='tour_form'>\
                                    <textarea rows='6' cols='25'></textarea>\
                                    <br><button type='button'>Submit</button>\
                                  </form>\
                                </div>"





$(document).ready(function() {
	var map;
  var styleOptions = [
                        {
                          "featureType": "poi",
                          "stylers": [
                            { "visibility": "off" }
                          ]
                        },{
                          "featureType": "poi.park",
                          "stylers": [
                            { "visibility": "on" }
                          ]
                        }
                      ]
  // console.log(mapOptions);

	function initialize() {
		var mapOptions = {
		  center: new google.maps.LatLng(0, 0),
		  zoom: 3,
		  streetViewControl: false,
		  styles: styleOptions
		};

		map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
	
	  var markers = [];
	  // var map = new google.maps.Map(document.getElementById('map-canvas'), {
	  //   mapTypeId: google.maps.MapTypeId.ROADMAP
	  // });

	  var defaultBounds = new google.maps.LatLngBounds(
	      new google.maps.LatLng(-60, -150),
	      new google.maps.LatLng(60, 150));
	  map.fitBounds(defaultBounds);
			

		google.maps.event.addListener(map, 'click', function(e) {
			var myLatLng = new google.maps.LatLng(e.latLng['d'], e.latLng['e'])
      var user_marker = new google.maps.Marker({
        position: myLatLng,
        map: map
      })
			google.maps.event.addListener(user_marker, 'click', function() {
        infowindow.open(map, user_marker);
      })
		});
  
    var infowindow = new google.maps.InfoWindow({
      content: tour_description_template
    });

    // google.maps.event.addListener(user_markers, 'click', function() {
    //   infowindow.open(map,user_marker);
    // });
    

		var input = (document.getElementById('pac-input'));
  	map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

  	var searchBox = new google.maps.places.SearchBox((input));

  // Listen for the event fired when the user selects an item from the
  // pick list. Retrieve the matching places for that item.
  	google.maps.event.addListener(searchBox, 'places_changed', function() {
    var places = searchBox.getPlaces();

    for (var i = 0, marker; marker = markers[i]; i++) {
      marker.setMap(null);
    }

    // For each place, get the icon, place name, and location.
    markers = [];
    var bounds = new google.maps.LatLngBounds();
    for (var i = 0, place; place = places[i]; i++) {
      var image = {
        url: place.icon,
        size: new google.maps.Size(71, 71),
        origin: new google.maps.Point(0, 0),
        anchor: new google.maps.Point(17, 34),
        scaledSize: new google.maps.Size(25, 25)
      };

      // Create a marker for each place.
      var marker = new google.maps.Marker({
        map: map,
        icon: image,
        title: place.name,
        position: place.geometry.location,
      });

      markers.push(marker);

      bounds.extend(place.geometry.location);
    }

    map.fitBounds(bounds);
  });

  // Bias the SearchBox results towards places that are within the bounds of the
  // current map's viewport.
  google.maps.event.addListener(map, 'bounds_changed', function() {
    var bounds = map.getBounds();
    searchBox.setBounds(bounds);
  });

	};

	google.maps.event.addDomListener(window, 'load', initialize);

});