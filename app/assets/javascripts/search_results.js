
var TourBox = function(first_name, tag_line, rating, tourDesc) {
this.template = $("<div class='tour_box'>\
                    <span class='ambassador_name_card'>" + first_name + "</span>\
                    <br><span class='ambassador_tagline'>" + tag_line + "</span>\
                    <br><span class='ambassador_tourDesc_card'>" + tourDesc + "</span>\
                  </div>")
};

var User = function(user_id, first_name, tag_line, rating, photo) {
  this.template = $("<div class='search_results_card'>\
                        <span class='ambassador_photo_card' style='background-image: url(&quot;"+photo+"&quot;)'></span>\
                        <span class='search_card_info'>\
                          <p class='ambassador_name_card'>" + first_name + "</p>\
                          <p class='ambassador_tag_line_card'>" + tag_line + "</p>\
                          <p class='ambassador_rating_card'>" + rating + "</p>\
                          <p class='search_contact_button_container'><a href='/users/" + user_id + "/tours' class='search_contact_button'>Contact</a></p>\
                        </span>\
                      </div>")
};


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


var map;
var initialLat = gon.lat
var initialLng = gon.lng

var coords = gon.points

var markers = [];
var marker_id = 0;

var infoWindows = []
$(document).ready(function() {

  // console.log(coords)
  var mapOptions = {
    center: new google.maps.LatLng(initialLat, initialLng),
    zoom: 7,
    streetViewControl: false,
    styles: styleOptions
  };

	function initialize() {
		map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);

    $.each(coords, function(i,v) {
      var myLatLng = new google.maps.LatLng(coords[i][0], coords[i][1])
      var tour_marker = new google.maps.Marker({
        position: myLatLng,
        map: map
      });
      markers.push(tour_marker)
    });

    google.maps.event.addListener(map, 'idle', function() {

      var data = { bounds :  map.getBounds().toString()}

      $.get('/search', data, function(response) {
        // console.log(response)
        $('.search_results_card').remove()
        $.each(markers, function(i,v) {
          v.setMap(null);
        });
        markers.length = 0

        $.each(response.points, function(i,v) {
          var myLatLng = new google.maps.LatLng(v[0], v[1])

          var tour_marker = new google.maps.Marker({
            position: myLatLng,
            map: map
          }); //end new marker
          var user = response['users'][v[2]]
          var tourBox = new TourBox(user.first_name, user.tagline, user.rating, v[3])
          var infoWindow = new google.maps.InfoWindow({ content : tourBox.template[0] })
          infoWindows.push(infoWindow);

          google.maps.event.addListener(tour_marker, 'click', function() {
            $.each(infoWindows, function(i, v) { v.close() });
            // infoWindow.setContent(tourBox.template[0])

            infoWindow.open(map, tour_marker);
          });

          markers.push(tour_marker);

          

        }); //end each

        // console.log(response.users)
        $.each(response.users, function(i,v) {
          // console.log(v)
            var user = new User(v.id, v.first_name, v.tagline, v.rating, v.photo)
            $('#search_results_list').append(user.template)
        });

      });//end ajax callback
    });//end event listener



    var input = (document.getElementById('pac-input-search'));
    // map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

    var searchBox = new google.maps.places.SearchBox(input);

    // Listen for the event fired when the user selects an item from the
    // pick list. Retrieve the matching places for that item.
    google.maps.event.addListener(searchBox, 'places_changed', function() {
      var places = searchBox.getPlaces();

      for (var i = 0, marker; marker = markers[i]; i++) {
        marker.setMap(null);
      }

      // For each place, get the icon, place name, and location.
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
      }; //end for loop

      map.fitBounds(bounds);
      map.setZoom(15)
    }); //end searchBox event listener

    // Bias the SearchBox results towards places that are within the bounds of the
    // current map's viewport.
    google.maps.event.addListener(map, 'bounds_changed', function() {
      var bounds = map.getBounds();
      searchBox.setBounds(bounds);
    });

  }; //end initialize

	google.maps.event.addDomListener(window, 'load', initialize);

});