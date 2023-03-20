import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="shopping-map"
export default class extends Controller {
  connect() {

    console.log("stimulus map");

    const successCallback = (position) => {
      const keyword = "amap"
      const radius = "1500"
      const key = ENV["GOOGLE_API_KEY"]
      const url = `https://maps.googleapis.com/maps/api/place/nearbysearch/json?keyword=${keyword}&location=${position.coords.latitude},${position.coords.longitude}&radius=${radius}&key=${key}`;

      const callback = (results, status) => {
        if (status == google.maps.places.PlacesServiceStatus.OK) {
          console.log(results.length);

          for (let i = 0; i < results.length; i++) {
            console.log(results[i]);
            console.log(results[i].geometry.location.lat());
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
          radius: '1500'
        };

        this.service = new google.maps.places.PlacesService(this.map);
        this.service.nearbySearch(request, callback);
      }

      initialize()


    };

    const errorCallback = (error) => {
      console.log(error);
    };

    const location = navigator.geolocation.getCurrentPosition(successCallback, errorCallback);
  }
}
