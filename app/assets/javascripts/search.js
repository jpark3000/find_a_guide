
$(document).ready(function() {
  var bounds;
  var input = (document.getElementById('pac-input'));
  var searchBox = new google.maps.places.SearchBox(input);


  google.maps.event.addListener(searchBox, 'places_changed', function() {
    var place = searchBox.getPlaces()[0];
    bounds = place.geometry.viewport;
    $('#initial_bounds').val(bounds.toString());
  });

  // google.maps.event.addDomListener(window, "resize", function() {
  //  var center = map.getCenter();
  //  google.maps.event.trigger(map, "resize");
  //  map.setCenter(center);
  // });


  //   if (!place.geometry) return;

  //   if (place.geometry.viewport) {
  //     console.log(place.geometry.viewport);
  //     bounds = place.geometry.viewport;
  //     $('#initial_bounds').val(bounds.toString());
  //     console.log($('#initial_bounds').val());
  //     $("#search_form").submit();
  //     // map.fitBounds(place.geometry.viewport);
  //   } else {
  //     console.log('poop')
  //     // map.setCenter(place.geometry.location);
  //     // map.setZoom(16);
  //   };
  // });

  // $('#search_form').on('submit', function(e) {
  //   e.preventDefault();
  // });


//   $('#search_form').on('keyup', function(e) {
//     // e.preventDefault();
//     if (e.keycode == 13) {
//       e.preventDefault();
//       google.maps.event.addListener(searchBox, 'places_changed', function() {
//   var place = searchBox.getPlaces()[0];

//   if (!place.geometry) return;

//   if (place.geometry.viewport) {
//     console.log(place.geometry.viewport);
//     bounds = place.geometry.viewport;
//     $('#initial_bounds').val(bounds.toString());
//     debugger
//     // map.fitBounds(place.geometry.viewport);
//   } else {
//     console.log('poop')
//     // map.setCenter(place.geometry.location);
//     // map.setZoom(16);
//   };

// });

//     }

//   });




  // $(input).on('keyup', function() {
  //   searchBox.getPlacePredictions({input: this.value}, function(predictions, status) {
  //     if (status === google.maps.places.PlacesServiceStatus.OK) {
  //         console.log(predictions);
  //     };
  //   });
  // });









  // google.maps.event.addListener(map, 'bounds_changed', function() {
  //   var bounds = map.getBounds();
  //   searchBox.setBounds(bounds);
  // });

// });




    // $('#pac-input').keyup(function(e) {
    //   if (e.keycode == 13) {
    //     var places = searchBox.getPlaces();
    //     bounds = places[0].geometry.viewport;
    //     console.log(bounds);
    //     $('#initial_bounds').val(bounds.toString());
    //   };
    // });

});
