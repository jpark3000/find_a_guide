$( document ).ready(function() {

  function getImages() {

    // Grab all FB albums for user
    FB.api('/me/albums', function (response) {
      // For each album in the response of all albums...
      for (album in response.data) {
        // If the album name is equal to Profile Pictures
        if (response.data[album].name == "Profile Pictures") {
          // Grab all photo objects from Profile Picture Album
          FB.api(response.data[album].id + "/photos", function(response) {

          // Limits the number of image results to a maximum of 5
          var limit5 = response.data.slice(0, 5);

          // Create HTML formString for modal
          var formString = '<h2 id="super_modal_h2">Pick a new profile picture!!!</h2>'

          // Add to formString
          $.each( limit5, function ( key, value ){
            formString = formString + '<form action="/update_profile_pic/' + gon.user_id + '" class="super_modal_form_styling" method="post"><input name="_method" type="hidden" value="patch" /><input type="image" name="profile_pic" value="' + value.images[0].source + '" id="profile_image1" src="' + value.images[0].source + '" height="80" width="80" alt="Submit Form" /></form>';
          });

          vex.open({
            content: formString
          });


          });
        }
      }
    });

  };//End getImages function

    $('#avatar_selector').on('click', function(event){
      event.preventDefault();

      getImages();
    }) //End Avatar Selector


}); //End Doc Ready
