 $(document).ready(function(){
  
  $("#form_specialty").submit(function(e){
    e.preventDefault();
    $("#response").empty();
    var url = $('#form_specialty').attr('action');
    var method = $('#form_specialty').attr('method');
    data = convertFormToJSON($('#form_specialty'));
    $.ajax({
          type: method,
          url: url,
          data: data,
          success: confirmSave,
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

var confirmSave = function (response) {
  $("#response").append("<li>Specialties Updated</li>");
}