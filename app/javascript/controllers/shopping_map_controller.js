import { Controller } from "@hotwired/stimulus"
// require('dotenv').config();

// Connects to data-controller="shopping-map"
export default class extends Controller {

  connect() {

    console.log("stimulus map");

    const successCallback = (position) => {
      const callback = (results, status) => {
        if (status == google.maps.places.PlacesServiceStatus.OK) {
          for (let i = 0; i < results.length; i++) {
            var myLatlng = new google.maps.LatLng(results[i].geometry.location.lat(),results[i].geometry.location.lng());
            var marker = new google.maps.Marker({
              position: myLatlng,
              title:"Hello World!"
          });
          marker.setMap(this.map);
          }
        }
      }
      const initialize = () => {
        let user_position = new google.maps.LatLng(position.coords.latitude,position.coords.longitude);

        this.map = new google.maps.Map(document.getElementById('map'), {
            center: user_position,
            zoom: 14
          });

        const request = {
          location: user_position,
          radius: '1500',
          query: "magasin bio"
        };

        this.service = new google.maps.places.PlacesService(this.map);
        this.service.textSearch(request, callback);
      }

      initialize()


    };

    const errorCallback = (error) => {
      console.log(error);
    };

    const location = navigator.geolocation.getCurrentPosition(successCallback, errorCallback);
  }
}
