import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-loader"
export default class extends Controller {

  connect() {
      console.log("Hellowwwwwww connecte");

  }
  runSearch(event) {
    console.log(this.element.innerHTML);
    event.preventDefault();
    this.element.innerHTML = `
    <div class="home_font_size" data-controller="search-loader">
    <div class="logo centered-element search">
    <p>On recherche les 3 meilleures recettes pour toi...</p>
    </div>
    <div class="search-loader">
    <img src="https://cdn.dribbble.com/users/393062/screenshots/14485663/media/0866b52b5c380d1441567c0b7db3038d.gif" alt="">
    </div>
    </div>`;
    let tID = setTimeout(function () {
      window.location.href = "recipes";
      window.clearTimeout(tID);		// clear time out.
  }, 3000);
  }
}
