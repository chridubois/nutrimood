import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="home-loader"
export default class extends Controller {
  connect() {
    // console.log("Hellowwwwwww");
    console.log(this.element);
    let tID = setTimeout(function () {
      window.location.href = "menu";
      console.log(this.element);
      window.clearTimeout(tID);		// clear time out.
  }, 2000);
  }
}
