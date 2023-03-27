import { Controller } from "@hotwired/stimulus"

// Connects to data-controller="search-loader"
export default class extends Controller {
  static targets = ["form", "animation"]

  connect() {
      console.log("Hellowwwwwww connecte");
  }
  runSearch(e) {
    e.preventDefault();
    this.formTarget.classList.add("d-none")
    this.animationTarget.classList.remove("d-none")
    setTimeout(() => {
      e.target.submit()
    }, 100);
  }
}
