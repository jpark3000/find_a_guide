$(document).ready(function(){
  var ajaxSubmit = new AjaxSubmit($("#availability_form"));
}); 

function AjaxSubmit(el){
  this.$el = el;
  this.url = this.$el.attr('action');
  this.httpMethod = this.$el.attr('method');
  var self = this;

  this.$el.submit(function(e){
    e.preventDefault();
    data = self.convertFormToJSON(self.$el);
    self.saveData(data);
  });
}

AjaxSubmit.prototype.convertFormToJSON = function (){
    var array = this.$el.serializeArray();
    var json = {};   
    jQuery.each(array, function() {
        json[this.name] = this.value || '';
    });
    return json;
}

AjaxSubmit.prototype.saveData = function (data) {
  var self = this;
  $.ajax({
          type: self.httpMethod,
          url: self.url,
          data: data,
          success: function(response){
            self.$el.find("span").html(response.current_status);
            self.$el.find("input[type='submit']").val(response.new_status);
            self.$el.find("#availability").val(response.new_value);
          },
          dataType: 'json'
    });
}
