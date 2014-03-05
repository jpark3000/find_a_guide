 $(document).ready(function(){

  $("#dialog-message").dialog({
      modal: true,
      dialogClass: "no-close",
      autoOpen: false,
      buttons: {
        Ok: function() {
          $( this ).dialog( "close" );
          window.location.href = '/dashboard';
        }
      }
    });

  $("form").submit(function(e){
    e.preventDefault();

    $("#errors").empty();
    var url = $('form').attr('action');
    var method = $('form').attr('method');
    data = convertFormToJSON($('form'));
    console.log(method);
    $.ajax({
          type: method,
          url: url,
          data: data,
          success: checkError,
          dataType: 'json'
    });
  });
});

var convertFormToJSON = function (form){
    var array = jQuery(form).serializeArray();
    var json = {};

    jQuery.each(array, function() {
        json[this.name] = this.value || '';
    });

    return json;
}

var checkError = function (response) {
  if (response.errors) {
    $.each(response.errors,function(index,value){
      $("#errors").append("<li>"+value+"</li>");
    });
  }
  else{
    $("#dialog-message").dialog('open');
  }
}
