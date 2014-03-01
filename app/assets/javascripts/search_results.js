
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


$(document).ready(function() {
  var mapOptions = {
    center: new google.maps.LatLng(initialLat, initialLng),
    zoom: 14,
    streetViewControl: false,
    styles: styleOptions
  };

	function initialize() {
		map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
  }; //end initialize

	google.maps.event.addDomListener(window, 'load', initialize);

});