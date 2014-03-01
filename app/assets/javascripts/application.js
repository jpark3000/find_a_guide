// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks


$(document).ready(function(){
    $("#main_search").css('margin-top', ($(document).height() / 2   ) + 'px');
    $("#dropdown").css('right', (($(document).width() - 1010) / 2));
    $("#profile_pic").click(function(){
        $("#dropdown").toggleClass('hide');
    });
    $(document).click(function(e){
        if(e.target.id !== "profile_pic"){
          $("#dropdown").addClass('hide');
        }
      }
    );

});

$(document).mouseup(function (e)
{
    var container = $("YOUR CONTAINER SELECTOR");

    if (!container.is(e.target) // if the target of the click isn't the container...
        && container.has(e.target).length === 0) // ... nor a descendant of the container
    {
        container.hide();
    }
});