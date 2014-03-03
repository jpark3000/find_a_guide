$(document).ready(function(){
  var ajaxSubmit = new AjaxSubmit($("#contact"));
}); 

function AjaxSubmit(el){
  this.$el = el;
  this.url = this.$el.attr('action');
  this.httpMethod = this.$el.attr('method');
  this.data = this.convertFormToJSON(this.$el);
  var self = this;

  this.$el.submit(function(e){
    e.preventDefault();
    $.ajax({
          type: self.httpMethod,
          url: self.url,
          data: self.data,
          success: self.confirmAction,
          dataType: 'json'
    });
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

AjaxSubmit.prototype.confirmAction = function () {
  var dialog = new Dialog($( "#dialog-message" ));
  dialog.show();
}


function Dialog(el) {
  this.$el = el
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

