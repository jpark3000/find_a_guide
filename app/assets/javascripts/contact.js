$(document).ready(function(){
  var ajaxSubmit = new AjaxSubmit($("#contact"));

  $('[data-behaviour~=datepicker]').datepicker({
      format: "MM dd yyyy",
      autoclose: true,
    });
});
function AjaxSubmit(el){
  this.$el = el;
  this.url = this.$el.attr('action');
  this.httpMethod = this.$el.attr('method');
  var self = this;

  this.$el.submit(function(e){
    e.preventDefault();
    data = self.convertFormToJSON(self.$el);
    $.ajax({
          type: self.httpMethod,
          url: self.url,
          data: data,
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
  var dialog = new Dialog($( "#dialog-message" ), $("#contact"));
  dialog.show();
}


function Dialog(el, form) {
  this.$el = el;
  this.$form = form;
  var self = this;
  this.$el.dialog({
    modal: true,
    dialogClass: "no-close",
    autoOpen: false,
    buttons: {
      Ok: function() {
        self.$form.remove();
        $( this ).dialog( "close" );
      }
    }
  });
}

Dialog.prototype.show = function(){
  this.$el.dialog('open');
}

