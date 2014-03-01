 $(document).ready(function(){
  
  $("form").submit(function(e){
    e.preventDefault();
    var url = $('form').attr('action');
    data = convertFormToJSON($('form'));
    console.log(url)
    $.ajax({
          type: "PUT",
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
      $("#errors").append(value);
    });
  }
  else{
    window.location.href = response.new_url;
  }
}