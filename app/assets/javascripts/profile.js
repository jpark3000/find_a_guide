 $(document).ready(function(){
  
  $("form").submit(function(e){
    e.preventDefault();
    $("#errors").empty();
    var url = $('form').attr('action');
    var method = $('form').find("input[name='_method']").val();
    data = convertFormToJSON($('form'));
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
  if (response.errors.length > 0) {
    $.each(response.errors,function(index,value){
      $("#errors").append("<li>"+value+"</li>");
    });
  }
  else{
    $("#saving_success").hide().fadeIn().html(" Your changes were saved successfully");
    var fade_out = function() {
      $("#saving_success").fadeOut();
    }

    setTimeout(fade_out, 3000);
  }
}

function Dialog(el) {
  this.$el = el;
  var self = this;
  this.$el.dialog({
    modal: true,
    dialogClass: "no-close",
    autoOpen: false,
    buttons: {
      Ok: function() {
        $( this ).dialog( "close" );
      }
    }
  });
}

Dialog.prototype.show = function(){
  this.$el.dialog('open');
}