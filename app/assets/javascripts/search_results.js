
var filter = function() {
  var specialtyId = $('.refine_specialty:checked').val();
}







var TourBox = function(first_name, tag_line, rating, tourDesc) {
this.template = $("<div class='tour_box'>\
                    <span class='card_name'>" + first_name + "</span>\
                    <br><span class='ambassador_tagline'>" + tag_line + "</span>\
                    <br><span class='ambassador_tourDesc_card'>" + tourDesc + "</span>\
                  </div>")
};

var User = function(user_id, first_name, tag_line, rating, photo) {
  this.template = $("<div class='card'>\
                        <span class='card_photo' style='background-image: url(&quot;"+photo+"&quot;)'></span>\
                        <span class='card_info'>\
                          <p class='card_name'>" + first_name + "</p>\
                          <p class='card_tagline'>" + tag_line + "</p>\
                          <p class='card_rating'>" + rating + "</p>\
                          <p class='search_contact_button_container'><a href='/users/" + user_id + "/tours' class='search_contact_button'>More Info</a></p>\
                        </span>\
                      </div>");
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
var initialBounds = gon.bounds


var coords = gon.points

var markers = [];
var marker_id = 0;

var infoWindows = []
$(document).ready(function() {
  console.log(initialBounds);
  var initialSWLatLng = new google.maps.LatLng(initialBounds[0], initialBounds[1])
  var initialNELatLng = new google.maps.LatLng(initialBounds[2], initialBounds[3])
  var initialMapBounds = new google.maps.LatLngBounds(initialSWLatLng, initialNELatLng)

  var mapOptions = {
    streetViewControl: false,
    mapTypeControl: false,
    panControl: false,
    minZoom: 2,
    zoomControlOptions: {
      style:google.maps.ZoomControlStyle.SMALL,
      position:google.maps.ControlPosition.TOP_RIGHT
    },
    styles: styleOptions
  };

	function initialize() {
		map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
    map.fitBounds(initialMapBounds);
    $.each(coords, function(i,v) {
      var myLatLng = new google.maps.LatLng(coords[i][0], coords[i][1])
      var tour_marker = new google.maps.Marker({
        position: myLatLng,
        map: map
      });
      markers.push(tour_marker)
    });

    google.maps.event.addListener(map, 'idle', function() {

      var data = { bounds :  map.getBounds().toString()};

      $.get('/search', data, function(response) {
        $('.card').remove()
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

            infoWindow.open(map, tour_marker);
          });

          markers.push(tour_marker);



        }); //end each

        $.each(response.users, function(i,v) {

          var user = new User(v.id, v.first_name, v.tagline, v.rating, v.photo);
          $('#search_results_list').append(user.template);

        });

        if(markers.length < 1 ){
          $('#no_ambassadors').html("No ambassadors found in this area.");
        } else {
          $('#no_ambassadors').html("");
        }

      });//end ajax callback
    });//end event listener



    var input = (document.getElementById('pac-input-search'));

    var searchBox = new google.maps.places.SearchBox(input);

    google.maps.event.addListener(searchBox, 'places_changed', function() {
      var places = searchBox.getPlaces();
      var bounds;
      for (var i = 0, place; place = places[i]; i++) {
        bounds = place.geometry.viewport;
      }; //end for loop

      map.fitBounds(bounds);
    }); //end searchBox event listener

  }; //end initialize

	google.maps.event.addDomListener(window, 'load', initialize);

  google.maps.event.addDomListener(window, "resize", function() {
   var center = map.getCenter();
   google.maps.event.trigger(map, "resize");
   map.setCenter(center);
  });

});
