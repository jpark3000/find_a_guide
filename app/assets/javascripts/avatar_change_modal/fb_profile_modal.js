$( document ).ready(function() {

  function getImages() {

    FB.api('/me/albums', function (response) {
      for (album in response.data) {

        if (response.data[album].name == "Profile Pictures") {

          FB.api(response.data[album].id + "/photos", function(response) {

          var image1 = response.data[0].images[0].source;
          var image2 = response.data[1].images[0].source;
          var image3 = response.data[2].images[0].source;
          var image4 = response.data[3].images[0].source;
          var image5 = response.data[4].images[0].source;

          vex.open({
          content: '<h2 id="super_modal_h2">Pick a new profile picture!!!</h2>\
                    <form action="/update_profile_pic/2" class="super_modal_form_styling" method="post"><input type="image" name="profile_pic" value="' + image1 + '" id="profile_image1" src="' + image1 + '" height="80" width="80" alt="Submit Form" /></form>\
                    <form action="/update_profile_pic/2" class="super_modal_form_styling" method="post"><input type="image" name="profile_pic" value="' + image2 + '" id="profile_image2" src="' + image2 + '" height="80" width="80" alt="Submit Form" /></form>\
                    <form action="/update_profile_pic/2" class="super_modal_form_styling" method="post"><input type="image" name="profile_pic" value="' + image3 + '" id="profile_image3" src="' + image3 + '" height="80" width="80" alt="Submit Form" /></form>\
                    <form action="/update_profile_pic/2" class="super_modal_form_styling" method="post"><input type="image" name="profile_pic" value="' + image4 + '" id="profile_image4" src="' + image4 + '" height="80" width="80" alt="Submit Form" /></form>\
                    <form action="/update_profile_pic/2" class="super_modal_form_styling" method="post"><input type="image" name="profile_pic" value="' + image5 + '" id="profile_image5" src="' + image5 + '" height="80" width="80" alt="Submit Form" /></form>'
          });

          });
        }
      }
    });

  }; //End getImages function



    $('#avatar_selector').on('click', function(event){
      event.preventDefault();

      getImages();
    }) //End Avatar Selector


}); //End Doc Ready
