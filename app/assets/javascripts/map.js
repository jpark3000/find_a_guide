
var Tour = function() {
  this.template = $("<div class='tour_desc'>\
                      <span id='message'></span>\
                      <div class='tour_text' contenteditable='true'></div>\
                      <a href='#' class='tour_creation_link' id='remove_marker'>Delete</a>\
                      <a href='#' class='tour_creation_link' id='new_tour_button'>Save</a>\
                      <a href='#' class='tour_creation_link' id='edit_tour'>Edit</a>\
                    </div>")
};

Tour.prototype.createdTour = function(description) {
  this.template.find('.tour_text').html(description);
  this.template.find('.tour_text').attr('contenteditable', false);
  this.template.find('#remove_marker').hide();
  this.template.find('#new_tour_button').hide();
  this.template.find('.tour_text').css('background-color', 'white')
  return this
};

Tour.prototype.editTour = function(tour_id) {
  var self = this
  this.template.find('#edit_tour').on('click', function() {
    self.template.find('.tour_text').attr('contenteditable', true);
    self.template.find('#new_tour_button').show();
    self.saveTour(tour_id)
  });
};

Tour.prototype.saveTour = function(tour_id) {
  var self = this
  this.template.find('#new_tour_button').on('click', function() {
    var newDesc = self.template.find('.tour_text').html()
    console.log(newDesc);
    $.ajax({
      url: '/users/' + gon.id + '/tours/' + tour_id, 
      type: 'PATCH',
      data: {newDesc : newDesc, tour_id : tour_id },
      dataType: 'json'
    })
      .done(function(response) {
        self.template.find('#message').html(response.message);
        self.template.find('#message').show();
        self.template.find('#message').fadeOut(1500);
        self.template.find('.tour_text').html(newDesc);
        self.createdTour(newDesc);
      });
  });
};
 
Tour.prototype.createTour = function() {
  this.template.find('#edit_tour').hide();
  return this
};

// var UserTour = function(description) {
//   this.template = $("<div class='tour_desc'>\
//                       <div class='tour_text'>" + description + "</div>\
//                       <br><button type='button' id='edit_tour'>Edit!</button>\
//                     </div>")
// };

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



var markers = [];

var marker_id = 0

$(document).ready(function() {
  // var userId = $('#availablity_title').data('id')
  console.log(gon.id);
	var map;

  var mapOptions = {
    center: new google.maps.LatLng(20, 0),
    zoom: 2,
    streetViewControl: false,
    styles: styleOptions
  };

  var user_markers = [];
  var info_windows = [];
  var userTourInfoWindows = []

	function initialize() {
		map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);
    var image = "/assets/ambassador.png"

    $.each(gon.points, function(index, tour) {
      var myLatLng = new google.maps.LatLng(tour.lat, tour.lng);
      var tour_marker = new google.maps.Marker({
        position: myLatLng,
        map: map,
        icon: image,
        animation: google.maps.Animation.DROP,
        tour_id: tour.id
      });

      var userTour = new Tour()

      var infoWindow = new google.maps.InfoWindow({ content : userTour.createdTour(tour.desc).template[0] })

      userTour.editTour(tour_marker.tour_id)

      userTourInfoWindows.push(infoWindow)

      google.maps.event.addListener(tour_marker, 'click', function() {
        $.each(userTourInfoWindows, function(index, userTourIW) { userTourIW.close(); });
        $.each(info_windows, function(i, tourIW) { tourIW.close(); });
        
        infoWindow.open(map, tour_marker)


      });
    });

	
		google.maps.event.addListener(map, 'click', function(e) {
      $.each(info_windows, function(i,v) { info_windows[i].close(); });
      $.each(userTourInfoWindows, function(index, userTourIW) { userTourIW.close(); });


			var myLatLng = new google.maps.LatLng(e.latLng['d'], e.latLng['e'])
      var user_marker = new google.maps.Marker({
        position: myLatLng,
        map: map
      })
      
      user_marker.set("id", marker_id++);
      var m_index = user_marker.get("id");
      user_markers.push(user_marker);
      
      var iw = new Tour().createTour()
    
      var infowindow = new google.maps.InfoWindow({content : iw.template[0] });

      $(infowindow.content).find('#remove_marker').on('click', function() { user_marker.setMap(null); user_marker=null });

      $(infowindow.content).find('#new_tour_button').on('click', function() {
        console.log('burgers')
        var data = {tour: {
                            description: $($($(this).parent()[0]).find('.tour_text')[0]).html(),
                            latitude: user_marker.position['d'],
                            longitude: user_marker.position['e']
                          }
                   }

        $.post('/users/' + gon.id + '/tours', data, function(response) {
          if (response.success) {
            $('body').append('<p>' + response.message + '</p>');
            $(infowindow.content).find('.tour_text').attr('contenteditable', false);
            $(infowindow.content).find('.tour_text').css('background-color', 'white');
            $(infowindow.content).find('#new_tour_button').hide(); 
            $(infowindow.content).find('#remove_marker').hide(); 
            $(infowindow.content).find('#edit_tour').show();
            iw.editTour(response.tour_id)
            user_marker.setIcon(image);
          } else {
            $('body').append('<p>' + response.message + '</p>');
          };
        });
      });

      info_windows.push(infowindow)
      info_windows[m_index].open(map, user_markers[m_index]);

      
      $.each(user_markers, function(i, v) {
        google.maps.event.addListener(user_markers[i], 'click', function() {
          $.each(info_windows, function(i,v) { info_windows[i].close(); });
          $.each(userTourInfoWindows, function(index, userTourIW) { userTourIW.close(); });
          info_windows[i].open(map, user_markers[i]);
        });
      });


    
		});// end listener


  
		var input = (document.getElementById('pac-input-tour'));
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