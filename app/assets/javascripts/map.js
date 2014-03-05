var tour_markers = {};
var Tour = function() {
  this.template = $("<div class='tour_desc'>\
                      <span id='message'></span>\
                      <textarea class='tour_text' placeholder='Enter a description!'></textarea>\
                      <div id='controls'>\
                        <span class='tour_creation_link' id='remove_marker'>Remove Marker</span>\
                        <span class='tour_creation_link' id='update_tour'>Update</span>\
                        <span class='tour_creation_link' id='new_tour_button'>Save</span>\
                        <span class='tour_creation_link' id='edit_tour'>Edit</span>\
                        <span class='tour_creation_link' id='delete_tour'>Delete Tour</span>\
                      </div>\
                    </div>")
};

Tour.prototype.createdTour = function(description) {
  this.template.find('.tour_text').val(description);
  this.template.find('.tour_text').attr('readonly', true);
  this.template.find('#delete_tour').hide();
  this.template.find('#remove_marker').hide();
  this.template.find('#new_tour_button').hide();
  this.template.find('#update_tour').hide();
  this.template.find('#edit_tour').show();
  this.template.find('.tour_text').css('background-color', 'white')
  return this;
};

Tour.prototype.editTour = function(tour_id) {
  var self = this;
  this.template.find('#edit_tour').on('click', function() {
    console.log('asdfas')
    self.template.find('#delete_tour').show();
    self.template.find('#edit_tour').hide();
    self.template.find('.tour_text').attr('readonly', false);
    self.template.find('#update_tour').show();
    self.updateTour(tour_id);
    self.deleteTour(tour_id);
  });
};

Tour.prototype.deleteTour = function(tour_id) {
  var self = this;
  this.template.find('#delete_tour').on('click', function() {
    var confirmDelete = confirm('Are you sure you want to delete this tour?')
    if (confirmDelete == true) {
    $.ajax({
      url: '/users/' + gon.id + '/tours/' + tour_id,
      type: 'DELETE',
      data: {tour_id : tour_id},
      dataType: 'json'
    })
      .done(function(response) {
        tour_markers[tour_id].setMap(null);
      });
    } else {
      return;
    };
  });
};

Tour.prototype.updateTour = function(tour_id) {
  var self = this;
  this.template.find('#update_tour').on('click', function() {

    var newDesc = self.template.find('.tour_text').val();

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
        self.template.find('.tour_text').val(newDesc);
        self.createdTour(newDesc);
      });
  });
};

Tour.prototype.createTour = function() {
  this.template.find('#edit_tour').hide();
  this.template.find('#delete_tour').hide();
  this.template.find('#update_tour').hide();
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
	var map;

  var mapOptions = {
    center: new google.maps.LatLng(20, 0),
    zoom: 2,
    minZoom: 2,
    streetViewControl: false,
    mapTypeControl: false,
    panControl: false,
    zoomControlOptions: {
      style:google.maps.ZoomControlStyle.SMALL,
      position: google.maps.ControlPosition.TOP_RIGHT
    },
    styles: styleOptions
  };

  
  var user_markers = [];
  var info_windows = [];
  var userTourInfoWindows = []

	function initialize() {
		map = new google.maps.Map(document.getElementById("map-canvas"), mapOptions);


    $.each(gon.points, function(index, tour) {
      var myLatLng = new google.maps.LatLng(tour.lat, tour.lng);
      var tour_marker = new google.maps.Marker({
        position: myLatLng,
        map: map,
        animation: google.maps.Animation.DROP,
        tour_id: tour.id
      });
      tour_markers[tour_marker.tour_id] = tour_marker
      console.log(tour_markers)
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

      var iw = new Tour()

      var infowindow = new google.maps.InfoWindow({content : iw.createTour().template[0] });

      $(infowindow.content).find('#remove_marker').on('click', function() { user_marker.setMap(null); user_marker=null });

      $(infowindow.content).find('#new_tour_button').on('click', function(e) {
        // e.preventDefault();
        console.log('sadfsdfds')
        var data = {tour: {
                            description: iw.template.find('.tour_text').val(),
                            latitude: user_marker.position['d'],
                            longitude: user_marker.position['e']
                          }
                   }

        $.post('/users/' + gon.id + '/tours', data, function(response) {
          if (response.success) {
            tour_markers[response.tour_id] = user_marker;
            iw.template.find('.tour_text').attr('readonly', true);
            iw.template.find('.tour_text').css('background-color', 'white');
            iw.template.find('#new_tour_button').hide();
            iw.template.find('#remove_marker').hide();
            iw.template.find('#edit_tour').show();
            iw.template.find('#delete_tour').hide();
            iw.editTour(response.tour_id)
          } else {
            $('#message').html(response.message);
            $('#message').show();
            $('#message').fadeOut(5000);
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
