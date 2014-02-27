






$(document).ready(function() {
	var map;
	function initialize() {
		var mapOptions = {
		  center: new google.maps.LatLng(0, 0),
		  zoom: 3,
		  streetViewControl: false
		};

	map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
	

		

		google.maps.event.addListener(map, 'click', function(e) {
			var myLatLng = new google.maps.LatLng(e.latLng['d'], e.latLng['e'])
			var marker = new google.maps.Marker({
				position: myLatLng,
				map: map
			});
		});
	};

	google.maps.event.addDomListener(window, 'load', initialize);

});