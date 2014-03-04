FB.api('/me/albums', function (response) {
  for (album in response.data) {

    // Find the Profile Picture album
    if (response.data[album].name == "Profile Pictures") {

      // Get a list of all photos in that album.
      FB.api(response.data[album].id + "/photos", function(response) {

        //The image link
        image = response.data[0].images[0].source;
        console.log(image)

      });
    }
  }
});
