// Place all the behaviors and hooks related to the matching controller here.
// All this logic will automatically be available in application.js.
// You can use CoffeeScript in this file: http://coffeescript.org/

function ready() {
  $('.logolink').on('click', function(e) {
    if (navigator.geoLocation) {
      navigator.geoLocation.getCurrentPosition(showPosition);
    } else {
      alert("Geolocation is not supported by this browser.")
    }
  });

  function showPosition(position) {
    var la = position.coords.latitude;
    var lo = position.coords.longitude;
    x.innerHTML = "Latitude: " + la + "<br>Longitude: " + lo;

    window.location.assign('<%= coupons_url %>' + '?lat=' + la + '&lon=' + lo);
  }
}

$(document).on('ready page:load', ready);
