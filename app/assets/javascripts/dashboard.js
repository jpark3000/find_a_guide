$(document).ready(function(){
  var forms = new AmbassadorFormView($("#ambassador_overlay"),$("#availability_form"));
  forms.displayForms();
});

function AmbassadorFormView (el1, el2){
  this.$el1 = el1;
  this.$el2 = el2;
  this.currentStatus = el1.data('ambassador');
  var ambassadorStatus = new BeAmbassador(el1, el2);
  var availabilityUpdate = new AjaxSubmit(el2);
}

AmbassadorFormView.prototype.displayForms = function(){
  if (this.currentStatus === true){
    this.$el2.show();
  }
  else{
    this.$el1.show();
  }
}

function BeAmbassador(el1, el2){
  this.$overlay = el1;
  this.$availability = el2;
  this.$el = el1.find('form');
  this.url = this.$el.attr('action');
  this.httpMethod = this.$el.find("input[name='_method']").val();
  var self = this;

  $("#become_ambassador").submit(function(e){
    e.preventDefault();
    $('#user_manage_tour_icon').show();
    data = self.convertFormToJSON(this.$el);
    self.updateStatus(data);
  });
}

BeAmbassador.prototype.convertFormToJSON = function (){
    var array = this.$el.serializeArray();
    var json = {};
    jQuery.each(array, function() {
        json[this.name] = this.value || '';
    });
    return json;
}

BeAmbassador.prototype.updateStatus = function (data) {
  var self = this;
  $.ajax({
          type: self.httpMethod,
          url: self.url,
          data: data,
          success: function(response){
            self.$overlay.hide();
            self.$availability.show();
          },
          dataType: 'json'
    });
}


function AjaxSubmit(el){
  this.$el = el;
  this.url = this.$el.attr('action');
  this.httpMethod = this.$el.find("input[name='_method']").val();
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

