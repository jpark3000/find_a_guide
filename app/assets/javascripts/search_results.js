
var Tour = function() {
this.template = $("<div class='tour_desc'>\
                    <div class='tour_text'></div>\
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
$(document).ready(function() {

  // console.log(coords)
  var mapOptions = {
    center: new google.maps.LatLng(initialLat, initialLng),
    zoom: 5,
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
    });

    google.maps.event.addListener(map, 'zoom_changed', function() {
      // console.log(map.getBounds().toString());

      var data = { bounds :  map.getBounds().toString()}
      $.post('/search', data, function(response) {
        console.log(response)
        $.each(response.points, function(i,v) {
          var myLatLng = new google.maps.LatLng(response.points[i][0], response.points[i][1])
          var tour_marker = new google.maps.Marker({
            position: myLatLng,
            map: map
          }); //end new marker
        }); //end each
        $('.amb').remove()
        $.each(response.users, function(i,v) {
          
        });

      });//end ajax callback
    });//end event listener

  }; //end initialize

	google.maps.event.addDomListener(window, 'load', initialize);

});