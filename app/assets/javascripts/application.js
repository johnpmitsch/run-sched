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
//= jquery.turbolinks
//= require turbolinks
//= require bootstrap-sprockets
//= require pikaday
//= require_tree .
$(document).ready(function() {
var picker = new Pikaday({ field: document.getElementById('datepicker') });


function hasHtml5Validation () {
  return false;
}

//check for html5 form validation, if it is not there, use css fallback
if (hasHtml5Validation()) {
  $('.new_schedule').submit(function (e) {
    if (!this.checkValidity()) {
      e.preventDefault();
      $(this).addClass('invalid');
    } else {
      $(this).removeClass('invalid');
    }
  });
}
});
