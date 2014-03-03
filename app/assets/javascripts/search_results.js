
var TourBox = function(first_name, tag_line, rating, tourDesc) {
this.template = $("<div class='tour_box'>\
                    <span class='ambassador_name_card'>" + first_name + "</span>\
                    <br><span class='ambassador_tag_line_card'>" + tag_line + "</span>\
                    <br><span class='ambassador_rating_card'>" + rating + "</span>\
                    <br><span class='ambassador_tourDesc_card'>" + tourDesc + "</span>\
                  </div>")
};

var User = function(user_id, first_name, tag_line, rating) {
  this.template = $("<a class='amb' href='/users/" + user_id + "/tours'>\
                      <div class='ambassador_tour_card'>\
                        <span class='ambassador_name_card'>" + first_name + "</span>\
                        <span class='ambassador_tag_line_card'>" + tag_line + "</span>\
                        <span class='ambassador_rating_card'>" + rating + "</span>\
                      </div>\
                    </a>")
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

      $.post('/search', data, function(response) {
        console.log(response)
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
          var user = response[v[2]]
          var tourBox = new TourBox(user.first_name, user.tagline, user.rating)
          var infoWindow = new google.maps.InfoWindow({ content : tourBox.template[0] })
          infoWindows.push(infoWindow);

          google.maps.event.addListener(tour_marker, 'click', function() {
            $.each(infoWindows, function(i, v) { v.close() });
            // infoWindow.setContent(tourBox.template[0])
            infoWindow.open(map, tour_marker);
          });

          markers.push(tour_marker);
        }); //end each

        $('.amb').remove()
        // $.each(response.users, function(i,v) {
        //   // console.log(v.id)
        //   var user = new User(v.id, v.first_name, v.tagline, '2 stars')
        //   $('#search_results_list').append(user.template)
        // });

      });//end ajax callback
    });//end event listener

  }; //end initialize

	google.maps.event.addDomListener(window, 'load', initialize);

});